

import 'package:flutter/material.dart';
import 'package:women_safty/core/text/custome.dart';

class ListContact extends StatelessWidget {
  final String contactEmail;
  final String phone;
  const ListContact({
    super.key,
    required this.contactEmail,
    required this.phone
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Customtext(text: contactEmail, color: Colors.white, size: 20, weight: FontWeight.bold),
              Customtext(text: phone, color: Colors.white, size: 17, weight: FontWeight.bold),
            ],
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.delete, color: Colors.white,),
          )
        ],
      ),
    );
  }
}