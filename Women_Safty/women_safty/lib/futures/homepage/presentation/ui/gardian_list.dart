import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/core/text/custome.dart';
import 'package:women_safty/core/utility/emails_text.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_event.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_state.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_bloc.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_event.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_state.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/widget/list_children.dart';
import 'package:women_safty/futures/message/presentation/state/messages_bloc.dart';
import 'package:women_safty/futures/message/presentation/state/messages_event.dart';

class GardianList extends StatefulWidget {
  const GardianList({super.key});

  @override
  State<GardianList> createState() => _GardianListState();
}

class _GardianListState extends State<GardianList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GuardianBloc>(context).add(GetGardian());
  }

  @override
  Widget build(BuildContext context) {
    bool logoutShowing = false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Customtext(
              text: 'My Gurdian',
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
                          print(state.guardianEntity.children.length);
                          return GestureDetector(
                              onTap: () {
                                context.read<MessagesBloc>().add(GetMessages(userEmail: emial, otherEmail: state.guardianEntity.children[index]['guardianEmail']));
                                Navigator.pushNamed(context, '/home-messages',
                                    arguments: state.guardianEntity.children[index]['guardianEmail']);
                              },
                              child: ListChildren(
                                  name: state.guardianEntity.children[index]['guardianEmail']));
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
