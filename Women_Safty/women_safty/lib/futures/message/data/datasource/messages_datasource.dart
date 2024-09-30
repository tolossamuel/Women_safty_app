
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/message/domain/entity/message_entity.dart';

abstract class MessagesDatasource {
  Future<Either<Failure,MessageEntity>> getMessages(String userEmail,String otherEmail);
  Future<Either<Failure,MessageEntity>>  sendMessage(String imageUrl,String text, String soundUrl,String senderEmail,String receiverEmail);
}


class MessagesDatasourceImpl extends MessagesDatasource {
  @override
  Future<Either<Failure, MessageEntity>> getMessages(String userEmail,String otherEmail) async{
    try {
      print(1222);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('messages')
        .get();

        print('==================');

        // Map and filter messages
        List<Map<String, dynamic>> messages = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Check if the user is either the sender or the receiver
          if (userEmail == data['senderEmail'] || userEmail == data['receiverEmail']) {
            return {
              'senderEmail': data['senderEmail'],
              'receiverEmail': data['receiverEmail'],
              'text': data['text'],
              'image1': data['imageUrl'],
              'soundUrl': data['soudUrl'],
            };
          }
          return null; // Return null for messages that don't match
        }).whereType<Map<String, dynamic>>().toList(); 
      print('==================');
      final messageEntity = MessageEntity(messages: messages);
      return Right(messageEntity);


    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, MessageEntity>> sendMessage(String imageUrl, String text, String soundUrl,String senderEmail,String receiverEmail) async{
    try {
      Map<String, dynamic> messageData = {
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'text': text,
      'imageUrl': imageUrl,  // Optional: can be an empty string if no image
      'soundUrl': soundUrl,  // Optional: can be an empty string if no sound
      'timestamp': FieldValue.serverTimestamp(),  // Firestore's current timestamp
      'participants': [senderEmail, receiverEmail],
    };
    await FirebaseFirestore.instance.collection('messages').add(messageData);
    return  getMessages(senderEmail,receiverEmail);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
