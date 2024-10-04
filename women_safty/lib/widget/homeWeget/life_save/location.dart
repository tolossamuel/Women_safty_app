


import 'package:flutter/material.dart';



class Locations extends StatelessWidget {
  final String locationImage;
  final String location;
  final Function onmaps;
  const Locations({super.key,required this.location,required this.locationImage,required this.onmaps});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  (){
       onmaps(location);
      },
      child: SizedBox(
        width: 100,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(5),
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:   const Color.fromARGB(255, 255, 255, 255),
                    boxShadow:  const [
                      BoxShadow(
                        color: Color.fromARGB(255, 192, 191, 191),
                        offset: Offset(0, 4),
                        spreadRadius: 3
                      )
                    ]
      
                  ),
                  child: ClipRRect(
                    child: Image(
                      image: AssetImage(locationImage),
                      fit:BoxFit.cover
                  ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            
            Text(location,
            style: TextStyle(
              color: Colors.black
            ),)
          ],
        ),
      ),
    );
  }
}