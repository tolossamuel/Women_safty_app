

import 'package:flutter/material.dart';

import 'package:women_safty/futures/message/presentation/widget/text.dart';

class RightText extends StatelessWidget {
  final String text;
  const RightText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.5,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MessageText(text: text, color: Colors.white, size: 15, weight: FontWeight.normal),
    );
  }
}