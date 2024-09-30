import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/core/bottom_bar/bottom_bar.dart';
import 'package:women_safty/core/text/custome.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_bloc.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_event.dart';
import 'package:women_safty/futures/contact/presentation/state/contact_bloc/contact_state.dart';
import 'package:women_safty/futures/contact/presentation/widget/add_contact.dart';
import 'package:women_safty/futures/contact/presentation/widget/list_contact.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: const Customtext(
                text: 'Tursted Contacts',
                color: Colors.white,
                size: 25,
                weight: FontWeight.bold),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AddContact(); // Display the RatingDialog UI
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Customtext(
                        text: 'Add Trusted Contact',
                        color: Colors.white,
                        size: 17,
                        weight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ContactBloc, ContactState>(
                  builder: (context, state) {
                    if (state is ContactLoadedState) {
                      return Expanded(

                        child: ListView.builder(
                          itemCount: state.contact.contact.length,
                          itemBuilder: (context, index) {
                            print(state.contact.contact[index]['contact']);
                            return ListContact(
                                contactEmail: state.contact.contact[index]['contact'],
                                phone: state.contact.contact[index]['phone']);
                          },
                        ),
                      );
                    } else if (state is ContactLoadingState) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap :(){
                          context.read<ContactBloc>().add(const GetContactEvent());
                        },
                        child: Container(
                          color: const Color.fromARGB(255, 199, 198, 198),
                          padding: const EdgeInsets.all(10),
                          child: const Center(
                            child: Customtext(
                                text: 'Error', color: Colors.red, size: 17, weight:FontWeight.bold,),
                          ),
                        ),
                      );
                    }
                    
                  },
                )
              ],
            ),
            
          ),
          bottomNavigationBar: const BottomBar(indicatore: 3,),),
    );
  }
}
