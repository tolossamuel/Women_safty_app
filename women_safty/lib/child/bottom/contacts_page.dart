import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:women_safty/database/db_service.dart';
import 'package:women_safty/model/contacts.dart';
import 'package:women_safty/utils/const.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<PhoneContact> contacts = [];
  List<PhoneContact> contactsFiltered = [];
  DatabaseHelper _databaseHelper = DatabaseHelper();

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    askPermissions();
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  filterContact() {
    List<PhoneContact> _contacts = [];
    _contacts.addAll(contacts);

    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((element) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlattened = flattenPhoneNumber(searchTerm);
        String contactName = element.fullName?.toLowerCase() ?? "";

        // Check if the contact's name contains the search term
        bool nameMatch = contactName.contains(searchTerm);
        if (nameMatch) {
          return true;
        }

        // If name doesn't match, check if the phone number matches the search term
        if (searchTermFlattened.isEmpty) {
          return false;
        }

        // Check if any phone number contains the search term
        String phoneNumber = element.phoneNumber?.number ?? "";
        String phoneFlattened = flattenPhoneNumber(phoneNumber);

        return phoneFlattened.contains(searchTermFlattened);
      });
    }

    setState(() {
      contactsFiltered = _contacts;
    });
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactsPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
      searchController.addListener(() {
        filterContact();
      });
    } else {
      handInvalidPermissions(permissionStatus);
    }
  }

  void handInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      dialogueBox(context, "Access to the contacts denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      dialogueBox(context, "Please grant contact permission in settings");
    }
  }

  Future<PermissionStatus> getContactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future<void> getAllContacts() async {
    // Use FlutterContactPicker to pick multiple contacts
    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
    
    setState(() {
      contacts = [contact]; // You can adjust this if you want to handle multiple contacts
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemExists = (contactsFiltered.isNotEmpty || contacts.isNotEmpty);
    
    return Scaffold(
      body: contacts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: true,
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: "Search contact",
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  listItemExists
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: isSearching ? contactsFiltered.length : contacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              PhoneContact contact = isSearching
                                  ? contactsFiltered[index]
                                  : contacts[index];
                              return ListTile(
                                title: Text(contact.fullName ?? ""),
                                subtitle: Text(contact.phoneNumber?.number ?? "No phone number"),
                                leading: CircleAvatar(
                                  backgroundColor: kColorRed,
                                  child: Text(contact.fullName?.substring(0, 1) ?? ""),
                                ),
                                onTap: () {
                                  String? phoneNum = contact.phoneNumber?.number;
                                  String name = contact.fullName ?? "Unknown";

                                  if (phoneNum != null && phoneNum.isNotEmpty) {
                                    _addContact(TContact(phoneNum, name));
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Oops! This contact has no phone number."
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        )
                      : Container(
                          child: Text("No contacts found"),
                        ),
                ],
              ),
            ),
    );
  }

  void _addContact(TContact newContact) async {
    int result = await _databaseHelper.insertContact(newContact);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Contact added successfully");
    } else {
      Fluttertoast.showToast(msg: "Failed to add contact");
    }
    Navigator.of(context).pop(true);
  }
}
