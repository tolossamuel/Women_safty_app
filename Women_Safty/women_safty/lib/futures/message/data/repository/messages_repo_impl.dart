

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/message/data/datasource/messages_datasource.dart';
import 'package:women_safty/futures/message/domain/entity/message_entity.dart';
import 'package:women_safty/futures/message/domain/repository/messages_repository.dart';

class MessagesRepoImpl  implements MessagesRepository{
  final MessagesDatasource messagesDatasource;
  MessagesRepoImpl({required this.messagesDatasource});
  @override
  Future<Either<Failure, MessageEntity>> getMessages(String userEmail, String otherEmail) async{
    try {
      return messagesDatasource.getMessages(userEmail, otherEmail);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage(String imageUrl, String text, String soundUrl, String senderEmail, String receiverEmail) async {
    try {
      return messagesDatasource.sendMessage(imageUrl, text, soundUrl, senderEmail, receiverEmail);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}