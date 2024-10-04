
import 'package:flutter/material.dart';
import 'package:women_safty/satrt/custom_text.dart';

class DataShow extends StatefulWidget {
  final String parentEmail;
  final String childName;
  final String childEmail;
  final String childPhone;
  final int parentNumber;
  const DataShow({super.key, required this.parentEmail, required this.childName, required this.childEmail, required this.childPhone, required this.parentNumber,});

  @override
  State<DataShow> createState() => _DataShowState();
}

class _DataShowState extends State<DataShow> {
  bool off = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.pink
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Customtext(text: 'Parent${widget.parentNumber}', color: Colors.black, size: 20, weight: FontWeight.bold),

          ),
          const SizedBox(
            height: 20,
          ),
          Customtext(text: 'Gurdian : ${widget.childName}', color: Colors.black, size: 15, weight: FontWeight.bold),
          Customtext(text: 'Gurdian-Email : ${widget.parentEmail}', color: Colors.black, size: 15, weight: FontWeight.bold),
          Customtext(text: 'Child-Email : ${widget.childEmail}', color: Colors.black, size: 15, weight: FontWeight.bold),
          Customtext(text: 'Phone : ${widget.childPhone}', color: Colors.black, size: 15, weight: FontWeight.bold),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Customtext(text: 'Delete User', color: Colors.black, size: 15, weight: FontWeight.bold),
             GestureDetector(
                onTap: (){
                  setState(() {
                    
                    off = !off;
                  });
                },
                child: Container(
                  
                  width: 40,
                  height: 23,
                  decoration: BoxDecoration(
                    color: off == false? Colors.grey : const Color.fromARGB(255, 159, 206, 245),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Align(
                    alignment: off == false?Alignment.centerLeft:Alignment.centerRight,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: off == false? Colors.white : Colors.blue,
                        border: Border.all(
                          color: off == false? Colors.grey : Colors.blue
                        )
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
          
        ],
      ),
    );
  }
}