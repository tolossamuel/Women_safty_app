import 'package:flutter/material.dart';
import 'dart:async';
import 'package:women_safty/admin/admin_page.dart';
import 'package:women_safty/child/bottom_page.dart';
import 'package:women_safty/database/shatedPreferance.dart';
import 'package:women_safty/parent/parent_home_screen.dart';
import 'package:women_safty/satrt/select_page.dart';
import 'package:women_safty/utils/const.dart'; // Make sure to import the class

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
      _rotationAnimation = Tween<double>(begin: -0.15, end: 0.15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth in and out
      ),
    );

   
    _controller.forward();

    // Delay and navigate to the correct screen
    _loadUserType();
  }

  Future<void> _loadUserType() async {
    String? userType = await MySharedPrefference.getUserType('usertype');

    // Wait for 3 seconds before navigation
    await Future.delayed(Duration(seconds: 3));

    if (userType == "admin") {
      goToAndReplaceAll(context, AdminPage());
      
    } else if (userType == "parent") {
      goToAndReplaceAll(context, ParentHomeScreen());
    } else if (userType == "child") {
     goToAndReplaceAll(context, BottomPage());
    } else {
      goToAndReplaceAll(context, SelectUserTypeScree());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle:  _rotationAnimation.value* 41.9 * 2,
              child: Container(
                width: 100,
                height: 100,
                child: Center(child: Image.asset('assets/womanSaftyLogo.png'))),
            );
          }
        ),
      ),
    );
  }
}
