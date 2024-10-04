

import 'package:flutter/material.dart';
import 'package:women_safty/admin/admin_login.dart';
import 'package:women_safty/child/login_screen.dart';
import 'package:women_safty/satrt/custom_text.dart';
import 'package:women_safty/utils/const.dart';

class ContainerText extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double rad;
  final int indicatore;
  final String rout;

  const ContainerText({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.rad,
    required this.indicatore,
    this.rout = 'login'
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (rout == 'login'){
          goTo(context, LoginScreen());
        } else if (rout == 'admin-login'){
          goTo(context, AdminLogin());
        } else {
          goTo(context, LoginScreen());
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(rad),
          color:  Colors.white,
          border: Border.all(
            color: const Color.fromARGB(255, 243, 119, 160),
          )
        ),
        child: Center(
          child: Customtext(
            text:  text,
            color: const Color.fromARGB(255, 243, 119, 160),
            size: 15,
            weight: FontWeight.normal,
      
          ),
        ),
      ),
    );
  }
}