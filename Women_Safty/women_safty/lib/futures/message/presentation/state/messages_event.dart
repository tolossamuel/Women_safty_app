
abstract class MessagesEvent{
  const MessagesEvent();
}


class GetMessages extends MessagesEvent{
  final String userEmail;
  final String otherEmail;
  GetMessages({required this.userEmail,required this.otherEmail});
}

class SendMessages extends MessagesEvent {
  final String imageUrl;
  final String text;
  final String soundUrl;
  final String senderEmail;
  final String receiverEmail;
  SendMessages({required this.imageUrl,required this.text,required this.soundUrl,required this.senderEmail,required this.receiverEmail});
}

class MessageInput extends MessagesEvent{
  final String text;
  MessageInput({required this.text});
}

