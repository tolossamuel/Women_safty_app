

import 'package:flutter/material.dart';
import 'package:women_safty/core/text/custome.dart';

class ListChildren extends StatelessWidget {
  final String name;

  const ListChildren({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 50, 0, 10),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.pink
        )
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle
            ),
            child: const ClipRRect(
              child: Image(
                image: AssetImage('assets/image/woman.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Customtext(text: name, color: Colors.black, size: 20, weight: FontWeight.normal),
          const Spacer(),
          const Icon(Icons.message, color: Colors.black,),
          
        ],
      ),
    );
  }
}