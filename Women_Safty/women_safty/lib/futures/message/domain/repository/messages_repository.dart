

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/message/domain/entity/message_entity.dart';

abstract class MessagesRepository {
  Future<Either<Failure, MessageEntity>> getMessages(String userEmail,String otherEmail);
  Future<Either<Failure, MessageEntity>> sendMessage(String imageUrl,String text, String soundUrl,String senderEmail,String receiverEmail);

}