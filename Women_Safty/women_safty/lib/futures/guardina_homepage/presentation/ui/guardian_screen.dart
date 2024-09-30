import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/core/text/custome.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_event.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_state.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_bloc.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_event.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_state.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/widget/list_children.dart';
import 'package:women_safty/futures/message/presentation/state/messages_bloc.dart';
import 'package:women_safty/futures/message/presentation/state/messages_event.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_bloc.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_event.dart';

class GuardianScreen extends StatefulWidget {
  const GuardianScreen({super.key});

  @override
  State<GuardianScreen> createState() => _GuardianScreenState();
}

class _GuardianScreenState extends State<GuardianScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GuardianBloc>(context).add(GetChildren());
  }

  @override
  Widget build(BuildContext context) {
    bool logoutShowing = false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Customtext(
              text: 'All Users',
              color: Colors.white,
              size: 25,
              weight: FontWeight.bold),
          actions: [
            Container(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 10, 0),
              child: GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(SignOut());
                },
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.pink,
                ),
                child: Customtext(
                    text: 'Gurdian Detail',
                    color: Colors.white,
                    size: 25,
                    weight: FontWeight.bold),
              ),
              ListTile(
                title: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/guardina-profile');
                    },
                    child: const Customtext(
                        text: 'Profile',
                        color: Colors.black,
                        size: 20,
                        weight: FontWeight.normal)),
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.arrow_forward_ios),
                
              ),
              ListTile(
                title: GestureDetector(
                    onTap: () {
                      context.read<RatingBloc>().add(GetRating());
                      print(111);
                      Navigator.pushNamed(context, '/gurdian-rating');
                    },
                    child: const Customtext(
                        text: 'User Rating',
                        color: Colors.black,
                        size: 20,
                        weight: FontWeight.normal)),
                leading: const Icon(Icons.person),
                trailing: const Icon(Icons.arrow_forward_ios),
                
              ),
              ListTile(
                title: GestureDetector(
                    onTap: () {
                    
                      context.read<AuthBloc>().add(SignOut());
                    },
                    child: const Customtext(
                        text: 'Logout',
                        color: Colors.black,
                        size: 20,
                        weight: FontWeight.normal)),
                leading: const Icon(Icons.lock),
                trailing: const Icon(Icons.arrow_forward_ios),
                
              ),
            ],
          ),
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
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: BlocBuilder<GuardianBloc, GuardianState>(
              builder: (context, state) {
                if (state is GuardianLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GuardianSuccessState) {
                  return BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, users) {
                      final String emial = users is AuthSuccess? users.authEntity.email: '';
                      return ListView.builder(
                        itemCount: state.guardianEntity.children.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                context.read<MessagesBloc>().add(GetMessages(userEmail: emial, otherEmail: state.guardianEntity
                                        .children[index]['email']));
                                Navigator.pushNamed(context, '/messages',
                                    arguments: state.guardianEntity
                                        .children[index]['email']);
                              },
                              child: ListChildren(
                                  name: state.guardianEntity.children[index]
                                      ['name']));
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Error'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
