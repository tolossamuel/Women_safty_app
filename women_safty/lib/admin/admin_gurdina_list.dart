

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:women_safty/admin/widget/list_component.dart';

class AdminGurdinaList extends StatefulWidget {
  const AdminGurdinaList({super.key});

  @override
  State<AdminGurdinaList> createState() => _AdminGurdinaListState();
}

class _AdminGurdinaListState extends State<AdminGurdinaList> {
  List<dynamic> parentDocuments = [];
  @override
  void initState() {
    super.initState();
    fetchParentDocuments();
  }
  Future<void> fetchParentDocuments() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
      List<dynamic> homepageData = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Check if the guardianEmail matches the user's email
        if ( 'parent' == data['type']) {
          return {
            'childEmail': data['childEmail'],
            'guardiantEmail': data['guardiantEmail'],
            'name': data['name'],
            'phone': data['phone'],
            
          };
        }
        return null; // Return null if the condition is not met
      }).where((item) => item != null).toList();
      setState(() {
        
        parentDocuments = homepageData;
      });
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch data'),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: const Text('Parent List',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
      ),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: parentDocuments.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: parentDocuments.length,
              itemBuilder: (context, index) {
                var document = parentDocuments[index];
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: DataShow(
                    parentEmail: document['guardiantEmail'],
                    childName: document['name'],
                    childEmail: document['childEmail'],
                    childPhone: document['phone'],
                    parentNumber: index + 1,
                  ),
                );
              },
            ),
    ));
  }
}