

import 'package:flutter/material.dart';
import 'package:women_safty/core/text/custome.dart';

class RatingContainer extends StatelessWidget {
  final String title;
  final String detail;
  final String star;
  const RatingContainer({super.key, required this.title, required this.detail, required this.star,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(20),

      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Customtext(text: title, color: Colors.white, size: 20, weight: FontWeight.bold)),
              Expanded(child: Customtext(text: detail, color: Colors.white, size: 16, weight: FontWeight.normal)),
          
            ],
          ),
          const Spacer(),
          const Icon(Icons.star, color: Colors.yellow,),
          Text('($star)')
        ],
      ),
    );
  }
}