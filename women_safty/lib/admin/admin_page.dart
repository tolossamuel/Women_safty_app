import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safty/admin/admin_child_list.dart';
import 'package:women_safty/admin/admin_gurdina_list.dart';
import 'package:women_safty/child/bottom/review_page.dart';
import 'package:women_safty/database/shatedPreferance.dart';
import 'package:women_safty/satrt/custom_text.dart';
import 'package:women_safty/satrt/select_page.dart';
import 'package:women_safty/utils/const.dart';
import 'package:women_safty/widget/homeWeget/saveHome/safeHome.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    logout() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure you want to logout "),
          actions: [
            PrimaryButton(
                title: "Confirm",
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                  try {
          
                    await FirebaseAuth.instance.signOut();
                    await MySharedPrefference.deleteUserType('usertype');
                   
                    goToAndReplaceAll(context, SelectUserTypeScree());
                  } on FirebaseAuthException catch (e) {
                    Navigator.pop(context);
                    dialogueBox(context, e.toString());
                  }
                }),
            Center(
              child: TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        );
      },
    );
  }
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Customtext(
            text: 'Welcome Admin',
            color: Colors.white,
            size: 25,
            weight: FontWeight.bold),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async{
                  logout();
                },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      
                    },
                    child: GestureDetector(
                      onTap: (){
                        goTo(context, AdminGurdinaList());
                      },
                      child: Container(
                        width: screenWidth * 0.4,
                        height: screenWidth * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 159, 170, 58)),
                        child: const Center(
                          child: Customtext(
                              text: 'Gurdina-Record ',
                              color: Colors.black,
                              size: 20,
                              weight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      goTo(context, AdminChildList());
                    },
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 246, 255, 170)),
                      child: const Center(
                        child: Customtext(
                            text: 'User-Record ',
                            color: Colors.black,
                            size: 20,
                            weight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: (){
                   goTo(context, ReviewPage());
                  },
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 234, 168, 250)),
                    child: const Center(
                      child: Customtext(
                          text: 'View-Ratings ',
                          color: Colors.black,
                          size: 25,
                          weight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}