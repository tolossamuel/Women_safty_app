

import 'package:flutter/material.dart';

class Customtext extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight weight;
  const Customtext({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    required this.weight,
    
    });

  @override
  Widget build(BuildContext context) {
    return Text(
      
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}