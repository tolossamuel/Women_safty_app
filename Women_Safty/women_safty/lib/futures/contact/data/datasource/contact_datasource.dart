

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/contact/data/model/contact_model.dart';
import 'package:women_safty/futures/contact/domain/entity/contact_entity.dart';

abstract class ContactDatasource {
  Future<Either<Failure,ContactEntity>> getContact();
  Future<Either<Failure,ContactEntity>> addContact(String contact,String phone);
}

class ContactDatasourceImpl implements ContactDatasource {
  final FirebaseAuth firebaseAuth;

  ContactDatasourceImpl({
    required this.firebaseAuth
  });
  @override
  Future<Either<Failure, ContactEntity>> getContact() async{
    try {
      final User? user = firebaseAuth.currentUser;

      if (user == null) {
        return Future.value(left(ServerFailure(message: "No authenticated user found")));
      }
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('contact').get();
      List<dynamic> homepageData = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Example structure of each document
      if (user.uid == data['userId']){
      return {
        'contact': data['contact'],
        'userId': data['userId'],
        'docId' : doc.id,
        'phone' : data['phone'],
      };
      }
      return null; // Return null if the condition is not met
      }).where((item) => item != null).toList();
    final ContactModel homepageModel = ContactModel(contact: homepageData, userId: user.uid);
    final ContactEntity homepageEntity = homepageModel.toEntity();
    return Right(homepageEntity);
    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
  @override
  Future<Either<Failure, ContactEntity>> addContact(String contact,String phone) async{
    try {
      final User? user = firebaseAuth.currentUser;

      if (user == null) {
        return Future.value(left(ServerFailure(message: "No authenticated user found")));
      }
      CollectionReference ratingCollection = FirebaseFirestore.instance.collection('contact');
      await ratingCollection.add({
        'contact': contact,
        'phone' : phone,
        'userId': user.uid,
      });
      return getContact();
    }
    catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
}