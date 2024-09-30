


import 'package:women_safty/futures/message/domain/entity/message_entity.dart';

abstract class MessagesState {}

class MessagesInitialState extends MessagesState {}

class MessagesLoadingState extends MessagesState {}

class MessagesLoadedState extends MessagesState {
  final MessageEntity messages;

  MessagesLoadedState({required this.messages});
}

class MessageErrorState extends MessagesState {
  final String message;

  MessageErrorState({required this.message});
}

class MessageInputState extends MessagesState {
  final String message;

  MessageInputState({required this.message});
}