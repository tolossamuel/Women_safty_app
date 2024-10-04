import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:women_safty/child/bottom/add_contact.dart';
import 'package:women_safty/child/bottom/chat_page.dart';
import 'package:women_safty/child/bottom/review_page.dart';
import 'package:women_safty/componet/far_bar_button.dart';
import 'package:women_safty/home_screen.dart';
import 'package:women_safty/profile_mode/settings.dart';


class BottomPage extends StatefulWidget {
  BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    AddContactsPage(),
    CheckUserStatusBeforeChat(),
    ReviewPage(),
    // // CheckUserStatusBeforeChatOnProfile(),
    SettingsPage()
  
  ];
  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: DefaultTabController(
          initialIndex: currentIndex,
          length: pages.length,
          child: Scaffold(
              body: pages[currentIndex],
              bottomNavigationBar: FABBottomAppBar(
                onTabSelected: onTapped,
                items: [
                  FABBottomAppBarItem(iconData: Icons.home, text: "home"),
                  
                  FABBottomAppBarItem(
                      iconData: Icons.contacts, text: "contacts"),
                      FABBottomAppBarItem(iconData: Icons.chat, text: "chat"),
                  FABBottomAppBarItem(
                      iconData: Icons.rate_review, text: "Ratings"),
                      FABBottomAppBarItem(
                      iconData: Icons.settings, text: "Settings"),
                ],
              )),
        ));
  }
}