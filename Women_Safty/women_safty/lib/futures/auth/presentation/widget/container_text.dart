

import 'package:flutter/material.dart';
import 'package:women_safty/core/text/custome.dart';

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
        
        Navigator.pushNamed(context, '/$rout');
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