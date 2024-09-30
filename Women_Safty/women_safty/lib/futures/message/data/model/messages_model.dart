

import 'package:women_safty/futures/message/domain/entity/message_entity.dart';

class MessagesModel  extends MessageEntity{
  MessagesModel({required super.messages});

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      messages: json['messages'],
    );
  }



  MessageEntity toEntity() => MessageEntity(messages: messages);
}