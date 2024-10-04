import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safty/chat_module/chat_screen.dart';
import 'package:women_safty/child/bottom/profile_page.dart';
import 'package:women_safty/child/bottom/review_page.dart';
import 'package:women_safty/database/shatedPreferance.dart';
import 'package:women_safty/satrt/select_page.dart';
import 'package:women_safty/utils/const.dart';



class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Container(),
            ),
            ListTile(

                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward_ios),
                title: TextButton(
                    onPressed: () async {
                      try {
                     
                        goTo(context, ProfilePage());
                      } on FirebaseAuthException catch (e) {
                        dialogueBox(context, e.toString());
                      }
                    },
                    child: Text(
                      "Profile",
                    ))),
            ListTile(
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward_ios),
                title: TextButton(
                    onPressed: () async {
                      try {
                    
                        goTo(context, ReviewPage());
                      } on FirebaseAuthException catch (e) {
                        dialogueBox(context, e.toString());
                      }
                    },
                    child: Text(
                      "User Rating",
                    ))),
            ListTile(
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.arrow_forward_ios),
                title: TextButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        await MySharedPrefference.deleteUserType('usertype');
                        goToAndReplaceAll(context, SelectUserTypeScree());
                      } on FirebaseAuthException catch (e) {
                        dialogueBox(context, e.toString());
                      }
                    },
                    child: Text(
                      "SING OUT",
                    ))),
            
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        // backgroundColor: Color.fromARGB(255, 250, 163, 192),
        title: Text("SELECT CHILD"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('type', isEqualTo: 'child')
            .where('guardiantEmail',
                isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: progressIndicator(context));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final d = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Color.fromARGB(255, 250, 163, 192),
                  child: ListTile(
                    onTap: () {
                      goTo(
                          context,
                          ChatScreen(
                              currentUserId:
                                  FirebaseAuth.instance.currentUser!.uid,
                              friendId: d.id,
                              friendName: d['name']));
                      // Navigator.push(context, MaterialPa)
                    },
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(d['name']),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}