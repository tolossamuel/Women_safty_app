


import 'package:flutter/material.dart';
import 'package:women_safty/satrt/container_text.dart';
import 'package:women_safty/satrt/custom_text.dart';

class SelectUserTypeScree extends StatelessWidget {
  const SelectUserTypeScree({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        
        body: Container(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
          width: double.infinity,
          height: double.infinity, // Ensure the container takes up the full height
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/start.jpg'), 
              fit: BoxFit.cover, // This will cover the entire container
            ),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Customtext(
                text:  'Login With your accound',
                size: 20,
                weight: FontWeight.bold,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 40,),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(49, 145, 141, 141), // Shadow color
                      offset: Offset(10, 10), // Shadow offset (x, y)
                      blurRadius: 8, // Blur radius
                      spreadRadius: 4, // Optional: spread radius
                    ),
                  ],
                ),
                // child: Image.asset('lib/assets/icon/main_logo.jpg'),
                child: ClipOval(child: Image.asset('assets/main_logo.jpg'))
  
              ),
              const SizedBox(
                height: 60,
              ),
              const ContainerText(
                text: 'Login As User',
                width: double.infinity,
                height: 60,
                rad: 10,
                indicatore: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              const ContainerText(
                rout: 'gardian-login',
                text: 'Login As Guardian',
                width: double.infinity,
                height: 60,
                rad: 10,
                indicatore: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              const ContainerText(
                rout: 'admin-login',
                text: 'Login As Admin',
                width: double.infinity,
                height: 60,
                rad: 10,
                indicatore: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}