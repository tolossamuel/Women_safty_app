


import 'package:flutter/material.dart';



class ImageMessage extends StatelessWidget {
  final String imageUrl;
  const ImageMessage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.5,
      height: width * 0.5,
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}