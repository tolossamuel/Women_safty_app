

import 'package:flutter/material.dart';
import 'package:women_safty/utils/quotes.dart';

class CustomeAppbar extends StatelessWidget {
  final Function onTap;
  final int indexs;
  final bool trans;
  const CustomeAppbar({super.key, required this.onTap, required this.indexs, required this.trans});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        child:trans? Text(sweetSayings[indexs],
        style: TextStyle(
          fontSize: 22,
          
        ),
        ): Text(transSayings[indexs],
        style: TextStyle(
          fontSize: 22,
          
        ),
        )
      ),
    );
  }
}