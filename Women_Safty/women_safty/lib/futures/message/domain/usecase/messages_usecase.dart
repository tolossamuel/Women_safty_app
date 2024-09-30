

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/message/domain/entity/message_entity.dart';
import 'package:women_safty/futures/message/domain/repository/messages_repository.dart';

class MessagesUsecase {
  final MessagesRepository messagesRepository;

  MessagesUsecase({required this.messagesRepository});

  Future<Either<Failure,MessageEntity>> getMessages(String userEmail,String otherEmail) async {
    return await messagesRepository.getMessages(userEmail,otherEmail);
  }

  Future<Either<Failure,MessageEntity>> sendMessage(String imageUrl,String text,String soudUrl ,String senderEmail,String receiverEmail) async {
    return await messagesRepository.sendMessage(imageUrl, text, soudUrl, senderEmail, receiverEmail);
  }

  
}