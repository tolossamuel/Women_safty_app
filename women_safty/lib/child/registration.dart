
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safty/child/login_screen.dart';

import 'package:women_safty/componet/custom_textfield.dart';
import 'package:women_safty/componet/secondaryBottom.dart';
import 'package:women_safty/model/user_model.dart';
import 'package:women_safty/utils/const.dart';
import 'package:women_safty/widget/homeWeget/saveHome/safeHome.dart';


class RegisterChildScreen extends StatefulWidget {
  @override
  State<RegisterChildScreen> createState() => _RegisterChildScreenState();
}

class _RegisterChildScreenState extends State<RegisterChildScreen> {
  bool isPasswordShown = true;
  bool isRetypePasswordShown = true;

  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();
  bool isLoading = false;

  _onSubmit() async {
    _formKey.currentState!.save();
    if (_formData['password'] != _formData['rpassword']) {
      dialogueBox(context, 'password and retype password should be equal');
    } else {
      progressIndicator(context);
      try {
        
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _formData['cemail'].toString(),
                password: _formData['password'].toString());
        if (userCredential.user != null) {
          
          
          final v = userCredential.user!.uid;
          DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('users').doc(v);

          final user = UserModel(
            name: _formData['name'].toString(),
            phone: _formData['phone'].toString(),
            childEmail: _formData['cemail'].toString(),
            guardianEmail: _formData['gemail'].toString(),
            verify: false,
            id: v,
            type: 'child',
          );
          final jsonData = user.toJson();
          await db.set(jsonData).whenComplete(() async{
            User? users = userCredential.user;
              if (users != null && !users.emailVerified) {
                await users.sendEmailVerification();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Verification email sent to ${users.email}. Please verify your email.'),
            ));
            }
            goToAndReplaceAll(context, LoginScreen());
            
          });
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          dialogueBox(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          dialogueBox(context, 'The account already exists for that email.');
        }
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        Navigator.pop(context);
        dialogueBox(context, e.toString());
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                    "REGISTER AS CHILD",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: kColorRed),
                                  ),
                                  Image.asset(
                                    'assets/logo.png',
                                    height: 100,
                                    width: 100,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomTextField(
                                      hintText: 'enter name',
                                      textInputAction: TextInputAction.next,
                                      keyboardtype: TextInputType.name,
                                      prefix: Icon(Icons.person),
                                      onsave: (name) {
                                        _formData['name'] = name ?? "";
                                      },
                                      validate: (email) {
                                        if (email!.isEmpty || email.length < 3) {
                                          return 'enter correct name';
                                        }
                                        return null;
                                      },
                                    ),
                                    CustomTextField(
                                      hintText: 'enter phone',
                                      textInputAction: TextInputAction.next,
                                      keyboardtype: TextInputType.phone,
                                      prefix: Icon(Icons.phone),
                                      onsave: (phone) {
                                        _formData['phone'] = phone ?? "";
                                      },
                                      validate: (email) {
                                        if (email!.isEmpty || email.length < 10) {
                                          return 'enter correct phone';
                                        }
                                        return null;
                                      },
                                    ),
                                    CustomTextField(
                                      hintText: 'enter email',
                                      textInputAction: TextInputAction.next,
                                      keyboardtype: TextInputType.emailAddress,
                                      prefix: Icon(Icons.person),
                                      onsave: (email) {
                                        _formData['cemail'] = email ?? "";
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
                                      hintText: 'enter guardian email',
                                      textInputAction: TextInputAction.next,
                                      keyboardtype: TextInputType.emailAddress,
                                      prefix: Icon(Icons.person),
                                      onsave: (gemail) {
                                        _formData['gemail'] = gemail ?? "";
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
                                        if (password!.isEmpty ||
                                            password.length < 7) {
                                          return 'enter correct password';
                                        }
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
                                    CustomTextField(
                                      hintText: 'retype password',
                                      isPassword: isRetypePasswordShown,
                                      prefix: Icon(Icons.vpn_key_rounded),
                                      validate: (password) {
                                        if (password!.isEmpty ||
                                            password.length < 7) {
                                          return 'enter correct password';
                                        }
                                        return null;
                                      },
                                      onsave: (password) {
                                        _formData['rpassword'] = password ?? "";
                                      },
                                      suffix: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isRetypePasswordShown =
                                                  !isRetypePasswordShown;
                                            });
                                          },
                                          icon: isRetypePasswordShown
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility)),
                                    ),
                                    PrimaryButton(
                                        title: 'REGISTER',
                                        onPressed: () {
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
                            SecondaryButton(
                                title: 'Login with your account',
                                onPressed: () {
                                  goTo(context, LoginScreen());
                                }),
                          ],
                        ),
                      ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}