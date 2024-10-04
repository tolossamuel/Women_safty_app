
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safty/admin/admin_page.dart';
import 'package:women_safty/componet/custom_textfield.dart';
import 'package:women_safty/database/shatedPreferance.dart';
import 'package:women_safty/utils/const.dart';
import 'package:women_safty/widget/homeWeget/saveHome/safeHome.dart';


class AdminLogin extends StatefulWidget {
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;

  void showSnackMessage(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2), // Customize the duration
  );
  
  // Display the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
  _onSubmit() async {
    _formKey.currentState!.save();

    try {
      

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _formData['email'].toString(),
        password: _formData['password'].toString(),
      );

   

      if (userCredential.user != null) {

        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          if (mounted) {
            
            Navigator.pop(context);
            if (value['type'] == 'admin') {
              MySharedPrefference.saveUserType('usertype','admin');
              goToAndReplaceAll(context, AdminPage());
            }
            else {
              showSnackMessage(context, 'only admin can login');
            }
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        showSnackMessage(context, 'No user found for that email.');
   
      } else if (e.code == 'wrong-password') {
        showSnackMessage(context, 'email or password is incorrect');
        
      } else {
        // Handle any other errors
        showSnackMessage(context, 'email or password is incorrect');
        
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
        
                
              ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Admin LOGIN",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: kColorRed),
                                ),
                                Image.asset(
                                  'assets/admin_logo.jpg',
                                  height: 100,
                                  width: 100,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomTextField(
                                    hintText: 'enter email',
                                    textInputAction: TextInputAction.next,
                                    keyboardtype: TextInputType.emailAddress,
                                    prefix: Icon(Icons.person),
                                    onsave: (email) {
                                      _formData['email'] = email ?? "";
                                    },
                                    validate: (email) {
                                      if (email!.isEmpty ||
                                          email.length < 3 ||
                                          !email.contains("@")) {
                                        return 'enter correct email';
                                      }
                                    },
                                  ),
                                  CustomTextField(
                                    hintText: 'enter password',
                                    isPassword: isPasswordShown,
                                    prefix: Icon(Icons.vpn_key_rounded),
                                    validate: (password) {
                                     
                                      return null;
                                    },
                                    onsave: (password) {
                                      _formData['password'] = password ?? "";
                                    },
                                    suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPasswordShown = !isPasswordShown;
                                          });
                                        },
                                        icon: isPasswordShown
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility)),
                                  ),
                                  PrimaryButton(
                                      title: 'LOGIN',
                                      onPressed: () {
                                        // progressIndicator(context);
                                        if (_formKey.currentState!.validate()) {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            });
                                         _onSubmit();
                                         
                                        }
                                      }),
                                ],
                              ),
                            ),
                          ),
                          
                          
                        ],
                      ),
                    ),
              ),
          ],
        ),
      )),
    );
  }
}