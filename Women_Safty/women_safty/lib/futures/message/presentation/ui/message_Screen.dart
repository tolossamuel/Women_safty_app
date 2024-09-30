import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/core/text/custome.dart';
import 'package:women_safty/core/utility/emails_text.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_bloc.dart';
import 'package:women_safty/futures/auth/presentation/state/auth_bloc/auth_state.dart';
import 'package:women_safty/futures/message/presentation/state/messages_bloc.dart';
import 'package:women_safty/futures/message/presentation/state/messages_event.dart';
import 'package:women_safty/futures/message/presentation/state/messages_state.dart';
import 'package:women_safty/futures/message/presentation/widget/image_message.dart';
import 'package:women_safty/futures/message/presentation/widget/right_text.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    String childEmail = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Customtext(
            text: 'Messages',
            color: Colors.white,
            size: 25,
            weight: FontWeight.bold),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // The main content part with messages
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 80.0), // Provide space for the input box
              child: Column(
                children: [
                  BlocBuilder<MessagesBloc, MessagesState>(
                    builder: (context, state){
                      if (state is MessagesLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MessagesLoadedState) {
                        
                        return BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, users) {
                            final emial = users is AuthSuccess? users.authEntity.email: '';
                            print(users);
                            print(111111111);
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: state.messages.messages.length,
                                  itemBuilder: (centext, index) {
                                    final current = state.messages.messages[index];
                                    final otherEmail = current['receiverEmail'];
                                    if (current['text'].isNotEmpty) {
                                      return Align(
                                              alignment: otherEmail == emial? Alignment.centerLeft: Alignment.centerRight,
                                              child: RightText(
                                                text: current['text'],
                                              ),
                                            );
                                        } else{
                                          return Align(
                                                  alignment: otherEmail == emial? Alignment.centerLeft: Alignment.centerRight,
                                                  child: ImageMessage(
                                                    imageUrl:
                                                        current['imageUrl'],
                                                  ),
                                                );
                                    }
                                  },
                                                      
                                                    ),
                            );
                          },
                        );
                      } else {
                        print(state);
                        return const Center(
                          child: Customtext(
                              text: 'say hi',
                              color: Colors.black,
                              size: 20,
                              weight: FontWeight.bold),
                        );
                      }
                      
                    },
                  ),
                  
                  
                ],
              ),
            ),

            // Input box positioned at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(16),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Expanded(
                      child: TextField(
                        onChanged: (value) {
                          context.read<MessagesBloc>().add(MessageInput(text: value));
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your message',
                          prefixIcon: Icon(Icons.attach_file),
                          border: InputBorder.none, // No border when idle
                          enabledBorder:
                              InputBorder.none, // No border when enabled
                          focusedBorder:
                              InputBorder.none, // No border when focused
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<MessagesBloc>().add(SendMessages(
                          imageUrl: '',
                          soundUrl:  '',
                          receiverEmail: childEmail,
                          senderEmail: EmailsText.emailText,
                          text: '',


                        ));
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
