

import 'package:flutter/material.dart';
import 'package:women_safty/core/text/custome.dart';

class Buttons extends StatelessWidget {
  final String text;

  final double height;
  final double rad;
  final Color color;
  final Color textColor;

  const Buttons({
    super.key,
    required this.text,
   
    required this.height,
    required this.rad,
    required this.color,
    required this.textColor
    });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(rad),
          color: color,
          border: Border.all(
            color: const Color.fromARGB(255, 243, 119, 160),
          )
        ),
        child: Center(
          child: Customtext(
            text:  text,
            color: textColor,
            size: 20,
            weight: FontWeight.normal,
      
          ),
        ),
      );
    
  }
}