import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safty/child/bottom/contacts_page.dart';
import 'package:women_safty/componet/primaryBottom.dart';
import 'package:women_safty/database/db_service.dart';
import 'package:women_safty/model/contacts.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  DatabaseHelper databasehelper = DatabaseHelper();
  List<TContact>? contactList;
  int count = 0;

  void showList() {
    Future<Database> dbFuture = databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContact>> contactListFuture =
          databasehelper.getContactList();
      contactListFuture.then((value) {
        setState(() {
          this.contactList = value;
          this.count = value.length;
        });
      });
    });
  }

  void deleteContact(TContact contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: "contact removed succesfully");
      showList();
    }
  }
  void phoneCall(String address) {
   
     launch('tel://' + address);
    
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (contactList == null) {
      contactList = [];
    }
    return SafeArea(
      child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              PrimaryButton(
                  title: "Add Trusted Contacts",
                  onPressed: () async {
                    bool result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactsPage(),
                        ));
                    if (result == true) {
                      showList();
                    }
                  }),
              Expanded(
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(contactList![index].name),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: ()  {
                                      phoneCall(contactList![index].number);
                                    },
                                    icon: Icon(
                                      Icons.call,
                                      color: Colors.red,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      deleteContact(contactList![index]);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}