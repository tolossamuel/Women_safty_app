import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/core/text/custome.dart';
import 'package:women_safty/futures/admin/presentation/state/admin_bloc.dart';
import 'package:women_safty/futures/admin/presentation/state/admin_event.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_event.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_state.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_bloc.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_event.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool logoutShowing = false;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Customtext(
            text: 'Welcome Admin',
            color: Colors.white,
            size: 25,
            weight: FontWeight.bold),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
                  context.read<AuthBloc>().add(SignOut());
                },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
          listener: (context, logout) {
            if (logout is AuthLogoutSeccuss) {
              logoutShowing = false;
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (Route<dynamic> route) => false,
              );
            } else if (logout is AuthError) {
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
            } else {
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
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      context.read<AdminBloc>().add(GetAdminData());
                      Navigator.pushNamed(context, '/gardian-data');
                    },
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 159, 170, 58)),
                      child: const Center(
                        child: Customtext(
                            text: 'Gurdina-Record ',
                            color: Colors.black,
                            size: 20,
                            weight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      context.read<AdminBloc>().add(GetAdminData());
                      Navigator.pushNamed(context, '/user-list');
                    },
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 246, 255, 170)),
                      child: const Center(
                        child: Customtext(
                            text: 'User-Record ',
                            color: Colors.black,
                            size: 20,
                            weight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: (){
                    context.read<RatingBloc>().add(GetRating());
                    Navigator.pushNamed(context, '/gurdian-rating');
                  },
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenWidth * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 234, 168, 250)),
                    child: const Center(
                      child: Customtext(
                          text: 'View-Ratings ',
                          color: Colors.black,
                          size: 25,
                          weight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
