

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/profile/presentation/state/getProfile_bloc/profile_bloc.dart';
import 'package:women_safty/futures/profile/presentation/state/getProfile_bloc/profile_event.dart';

class TextWidget extends StatelessWidget {

  final Icon icon;
  final double height;
  final String name;
  const TextWidget({
    super.key,

    required this.height,
    required this.icon,
    this.name = 'name'
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
      child: TextFormField(

            initialValue: name.isEmpty ? '' : name,
            onChanged:  (value) {
              context.read<ProfileBloc>().add(ProfileInput(name: value));
            },
          
            
            
            decoration:   InputDecoration(
              hintText: 'name',
              suffixIcon: icon,
               // Hint text for email input
              border: InputBorder.none, // No border when not focused
              focusedBorder: InputBorder.none, // No border when focused
              enabledBorder: InputBorder.none, // No border when enabled
              hintStyle:  const TextStyle(color: Color.fromARGB(255, 63, 62, 62)), // Styling for hint text
            ),
          )
    );
  }
}