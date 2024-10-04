


import 'package:flutter/material.dart';


class CardImage extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String webstite;
  final Function webste;
  const CardImage({super.key, required this.text, required this.imageUrl, required this.webstite, required this.webste});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        if (imageUrl.isNotEmpty){
          print(webstite);
        webste(webstite);
        }
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(5,10,5,10),
        width:  screenWidth * 0.9,
        height: screenWidth * 0.6,
        decoration: BoxDecoration(
          color: const Color.fromARGB(100, 226, 225, 225),
          borderRadius: BorderRadius.circular(10),
         
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageUrl.isEmpty? const SizedBox(): Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 10,
              left : 10,
              child: SizedBox(
                child: Text(
                          text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                        ),
              )
            )
          ]
        ),
      ),
    );
  }
}