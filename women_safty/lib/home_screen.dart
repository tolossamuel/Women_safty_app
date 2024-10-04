


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:women_safty/database/shatedPreferance.dart';
import 'package:women_safty/widget/customCarouel.dart';
import 'package:women_safty/widget/custome_appBar.dart';
import 'package:women_safty/widget/homeWeget/emergency.dart';
import 'package:women_safty/widget/homeWeget/life_save/life_save.dart';
import 'package:women_safty/widget/homeWeget/saveHome/safeHome.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int qIndex = 0;
 
   String isOnLeft = 'IN'; 
  getRandomQout() {
    Random  random = Random();
    
    setState(() {
      qIndex = random.nextInt(6);
    });
  }
  @override
  void initState() {
    getRandomQout();
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: CustomeAppbar(
                      indexs: qIndex,
                      onTap: getRandomQout,
                      trans : isOnLeft == 'IN' ? true : false,
                    ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                isOnLeft = result;  // Update selected language
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'IN',
                child: Text('IN'),
              ),
              const PopupMenuItem<String>(
                value: 'EN',
                child: Text('EN'),
              ),
            ],
            icon: Icon(Icons.language),  // Icon for the action button
            tooltip: 'Choose Language',
          ),
        ],
      ),
      body: Column(
      
        children: [
          
          
          Expanded(
            child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Customcarouel(trans : isOnLeft == 'IN' ? true : false,),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Emergency', style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Emergency(),
                      SizedBox(
                        height: 10,
                      ),
                  
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: const Text('Explore LiveSafe', 
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const LifeSave(),
                      SizedBox(
                        height: 10,
                      ),
                      SafeHome(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}