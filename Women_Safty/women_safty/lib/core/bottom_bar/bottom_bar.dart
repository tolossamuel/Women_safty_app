

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/core/utility/emails_text.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_bloc.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_event.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_bloc.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_event.dart';

class BottomBar extends StatelessWidget {
  final int indicatore;
  const BottomBar({super.key, required this.indicatore});

  @override
  
  Widget build(BuildContext context) {
    print(indicatore);
    return Container(
      
      color: const Color.fromARGB(255, 230, 228, 228),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (indicatore != 1){
                Navigator.pop(context);
              }
            },
            child: Icon(Icons.home, color: indicatore== 1? Colors.blue:Colors.grey,size: 35,)),
          GestureDetector(
            onTap: () {
                if (indicatore == 1){
                  context.read<ContactBloc>().add(const GetContactEvent());
                  Navigator.pushNamed(context,'/gardian-text');
                }
                else if (indicatore != 2) {
                  context.read<ContactBloc>().add(const GetContactEvent());
                  Navigator.popAndPushNamed(context, '/gardian-text',);
                }
              },
            child: Icon(Icons.message, color: indicatore== 2? Colors.blue:Colors.grey,size: 35,)),
          GestureDetector(
            onTap: () {
              if (indicatore == 1){
               
                context.read<ContactBloc>().add(const GetContactEvent());
                Navigator.pushNamed(context,'/contact-screen');
              }
              else if (indicatore != 3) {
                context.read<ContactBloc>().add(const GetContactEvent());
                Navigator.popAndPushNamed(context, '/contact-screen');
              }
            },
            child: Icon(Icons.contact_phone, color: indicatore== 3? Colors.blue:Colors.grey,size: 35,)),
          GestureDetector(
            onTap: () {
              if (indicatore == 1){
                Navigator.pushNamed(context,'/profile-page');
              }
              else if (indicatore != 4) {
                
                Navigator.popAndPushNamed(context, '/profile-page');
              }
            },
            child: Icon(Icons.person, color: indicatore== 4? Colors.blue:Colors.grey,size: 35,)),
          GestureDetector(
            onTap: (){
             
              if (indicatore == 1){
                context.read<RatingBloc>().add(GetRating());
                Navigator.pushNamed(context,'/rating-screen');
              }
              else if (indicatore != 5) {
                context.read<RatingBloc>().add(GetRating());
                Navigator.popAndPushNamed(context, '/rating-screen');
              }
            },
            child: Icon(Icons.edit_note_outlined, color: indicatore== 5? Colors.blue:Colors.grey,size: 35,))
        ],
      ),
    );
  }
}