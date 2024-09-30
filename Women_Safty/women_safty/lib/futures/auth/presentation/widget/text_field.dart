

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_event.dart';

class TextFields extends StatelessWidget {
  final String text;
  final Icon icon;
  final double height;
  const TextFields({
    super.key,
    required this.text,
    required this.height,
    required this.icon
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: height,
      
      width: double.infinity,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
        color: Colors.grey
      ),
      child: TextField(
            onChanged:  (value) {
              context.read<AuthBloc>().add(AuthInput(indicatore: text.toLowerCase(), text: value));
            },
            
            keyboardType: text.contains('Email') ? TextInputType.emailAddress: TextInputType.text ,
            obscureText: text.contains('Password') ? true: false,
            decoration: InputDecoration(
              
              suffixIcon: icon,
              hintText: text, // Hint text for email input
              border: InputBorder.none, // No border when not focused
              focusedBorder: InputBorder.none, // No border when focused
              enabledBorder: InputBorder.none, // No border when enabled
              hintStyle: const TextStyle(color: Color.fromARGB(255, 63, 62, 62)), // Styling for hint text
            ),
          )
    );
  }
}