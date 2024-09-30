

import 'package:flutter/material.dart';

class CenterCard extends StatelessWidget {
  final String topImage;
  final String callNumber;
  final String message;

  const CenterCard({super.key, required this.topImage, required this.callNumber, required this.message});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width :screenWidth* 0.7,
      height : screenWidth * 0.5,
      child: Stack(
        children: [
          
          Container(
            margin: const EdgeInsets.fromLTRB(5,10,5,10),
            padding: const EdgeInsets.all(10),
            width :screenWidth* 0.7,
            height : screenWidth * 0.5,
            decoration: BoxDecoration(
          
            gradient: const LinearGradient(
              begin: Alignment.topLeft,  // Start point
              end: Alignment.bottomRight, // End point
              colors: [
                Colors.pink,  
                Colors.pink,    // You can change these to any colors
                Colors.orange,  // You can add more colors if needed
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: SizedBox(
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(message, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                Text('call $callNumber for emergency', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text(callNumber, style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 15)),),
                )
              ],
          
            ),
          ),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape:BoxShape.circle,
                color:   Color.fromARGB(200, 248, 215, 215)
              ),
              child: ClipRRect(
                child: Image(
                  image: AssetImage(topImage),
                  fit:BoxFit.cover
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}