import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/core/bottom_bar/bottom_bar.dart';
import 'package:women_safty/core/text/custome.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_event.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_state.dart';
import 'package:women_safty/futures/auth/presentation/widget/buttons.dart';
import 'package:women_safty/futures/profile/presentation/state/getProfile_bloc/profile_bloc.dart';
import 'package:women_safty/futures/profile/presentation/state/getProfile_bloc/profile_event.dart';
import 'package:women_safty/futures/profile/presentation/state/getProfile_bloc/profile_state.dart';

import 'package:women_safty/futures/profile/presentation/widget/text_filed.dart';

class GurdinaProfile extends StatelessWidget {
  const GurdinaProfile({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDialogShowing = false;
    bool logoutShowing = false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Customtext(
              text: 'Profile',
              color: Color.fromARGB(255, 255, 255, 255),
              size: 20,
              weight: FontWeight.bold),
          centerTitle: true,
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, logout) {
            if (logout is AuthLogoutSeccuss){
              logoutShowing = false;
              Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', 
                      (Route<dynamic> route) => false, 
                    );

            }
            else if (logout is AuthError){
              if (logoutShowing) {
                  logoutShowing = false;
                  Navigator.pop(context);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(logout.message),
                    duration: const Duration(seconds: 2),
                  ),
                );
            }
            else {
              logoutShowing = true;
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
            }
          },
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoadingState) {
                print(123411);
                isDialogShowing = true;
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
              } else if (state is ProfileErrorState) {
                if (isDialogShowing) {
                  isDialogShowing = false;
                  Navigator.pop(context);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
              child: Column(
                children: [
                  const Customtext(
                      text: 'Update Your Profile Here...',
                      color: Colors.pink,
                      size: 20,
                      weight: FontWeight.bold),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, profile) {
                      if (profile is ProfileLoaded) {
                        if (isDialogShowing) {
                          isDialogShowing = false;
                          Navigator.pop(context);
                        }
                        return TextWidget(
                          height: 60,
                          icon: const Icon(
                            Icons.border_color,
                            color: Colors.pink,
                          ),
                          name: profile.profileEntity.user['name'],
                        );
                      } else {
                        return const TextWidget(
                          height: 60,
                          icon: Icon(
                            Icons.border_color,
                            color: Colors.pink,
                          ),
                          name: '',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<ProfileBloc>().add(ProfileUpdateEvent());
                    },
                    child: const Buttons(
                      text: 'Update',
                      height: 60,
                      rad: 20,
                      color: Colors.pink,
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(SignOut());
                    },
                    child: const Buttons(
                      text: 'LogOut',
                      height: 60,
                      rad: 20,
                      color: Color.fromARGB(255, 255, 255, 255),
                      textColor: Colors.pink,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        
      ),
    );
  }
}
