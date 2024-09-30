


import 'package:flutter/material.dart';

import 'package:women_safty/core/text/custome.dart';

class ShareLocation extends StatefulWidget {

  const ShareLocation({super.key});

  @override
  State<ShareLocation> createState() => _ShareLocationState();
}

class _ShareLocationState extends State<ShareLocation> {
  
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      
      width: screenWidth,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        
        
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width : (screenWidth*0.4),
            height: 300,
            child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Customtext(text: 'Send Location', color: Colors.black, size: 20, weight: FontWeight.bold),
                Customtext(text: 'share location', color: Colors.black, size: 15, weight: FontWeight.normal)],
            ),
          ),
          SizedBox(
            width: (screenWidth * 0.45),
            child: const Image(
              image: AssetImage('assets/image/route.jpg'),
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}