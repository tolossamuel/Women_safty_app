import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/core/text/custome.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_event.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_state.dart';
import 'package:women_safty/futures/auth/presentation/widget/buttons.dart';
import 'package:women_safty/futures/auth/presentation/widget/text_field.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final int? indicatore = ModalRoute.of(context)?.settings.arguments as int?;
    return SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            print(123411);
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                });
          } else if (state is AuthFailure) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('OK'))
                    ],
                  );
                });
          } else if (state is AuthError) {
            print(123455);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is AuthSuccess) {
            print(123455555);
             Navigator.pushNamedAndRemoveUntil(
                context,
                '/admin-page',
                (Route<dynamic> route) => false, 
              );
          }
        },
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
            width: double.infinity,
            height: double
                .infinity, // Ensure the container takes up the full height
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Customtext(
                      text: 'Admin Login',
                      size: 20,
                      weight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(
                                  49, 145, 141, 141), // Shadow color
                              offset: Offset(10, 10), // Shadow offset (x, y)
                              blurRadius: 8, // Blur radius
                              spreadRadius: 4, // Optional: spread radius
                            ),
                          ],
                        ),
                        child: ClipOval(
                            child: Image.asset('assets/image/admin_logo.jpg'))),
                    const SizedBox(
                      height: 40,
                    ),
                    const TextFields(
                      text: 'Email...',
                      icon: Icon(
                        Icons.email,
                        color: Colors.pink,
                      ),
                      height: 50,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextFields(
                      text: 'Password...',
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.pink,
                      ),
                      height: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {

                        print(111);
                        context.read<AuthBloc>().add(SignIn());
                      },
                      child: const Buttons(
                        text: 'Login',
                        color: Colors.pink,
                        height: 60,
                        rad: 10,
                        textColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
