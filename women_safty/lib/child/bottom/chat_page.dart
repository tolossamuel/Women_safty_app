import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safty/chat_module/chat_screen.dart';
import 'package:women_safty/child/login_screen.dart';
import 'package:women_safty/parent/parent_home_screen.dart';

class CheckUserStatusBeforeChat extends StatelessWidget {
  const CheckUserStatusBeforeChat({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if user is logged in
        if (snapshot.hasData && snapshot.data != null) {
          final currentUser = FirebaseAuth.instance.currentUser;

          // Fetch user type from Firestore
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("id", isEqualTo: currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snap.hasData && snap.data != null) {
                final userDoc = snap.data!.docs.first;

                // Redirect based on user type
                if (userDoc['type'] == "parent") {
                  return const ParentHomeScreen();
                } else {
                  return const ChatPage();
                }
              }

              // If no data found, display error message
              return const Center(child: Text("User data not found"));
            },
          );
        } else {
          Fluttertoast.showToast(msg: 'Please log in first');
          return  LoginScreen();
        }
      },
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text("SELECT GUARDIAN"),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('type', isEqualTo: 'parent')
              .where('childEmail', isEqualTo: FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            // Display list of parent users linked to the child's email
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final parentUser = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 250, 163, 192),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        _goToChatScreen(
                          context,
                          parentUser.id,
                          parentUser['name'],
                        );
                      },
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(parentUser['name']),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Function to navigate to ChatScreen
  void _goToChatScreen(BuildContext context, String friendId, String friendName) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          currentUserId: currentUserId,
          friendId: friendId,
          friendName: friendName,
        ),
      ),
    );
  }
}
