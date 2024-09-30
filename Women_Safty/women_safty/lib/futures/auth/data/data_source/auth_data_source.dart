

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/core/utility/emails_text.dart';
import 'package:women_safty/futures/auth/data/model/auth_model.dart';
import 'package:women_safty/futures/auth/domain/entity/auth_entity.dart';

abstract class AuthDataSource {
  Future<Either<Failure,AuthEntity>> signInWithEmailAndPassword(String email, String password);
  Future<Either<Failure,bool>> signOut();
  Future<Either<Failure,AuthEntity>>  signUp(String name,String email,String guardian, String phone, String password);
}

class AuthDataSourceImpl implements AuthDataSource {
 
  final FirebaseAuth firebaseAuth;
  AuthDataSourceImpl({
    required  this.firebaseAuth
  });
  @override
  Future<Either<Failure, AuthEntity>> signInWithEmailAndPassword(String email, String password) async {
    try {
  
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
  
      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
         if (userData != null) {
          String name = userData['name'] ?? '';
          String email = userData['email'] ?? '';
          String guardianEmail = userData['guardianEmail'] ?? '';
          String phoneNumber = userData['phoneNumber'] ?? '';
          EmailsText.emailText = email;
          EmailsText.userIds = user.uid;
          final AuthModel authModel = AuthModel(
            email: email, 
            name: name,
            phone: phoneNumber,
            guardian: guardianEmail
            );
          final AuthEntity authEntity = authModel.toEntity();

          return Right(authEntity);
         }}
        
      } 
        
      return Left(ServerFailure(message: 'User not found'));
    
    } catch (e) {
      
      return Left(ServerFailure(message: 'try again'));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await firebaseAuth.signOut();
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
  
  @override
  Future<Either<Failure, AuthEntity>> signUp(String name,String email,String guardian, String phone, String password) async{
    try {
        UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;
        if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'guardianEmail': guardian,
        'phoneNumber': phone,
       
      });

      // Return success
      final AuthModel authModel = AuthModel(
            email: email, 
            name: name,
            phone: phone,
            guardian: guardian
        );
        EmailsText.emailText = email;
        EmailsText.userIds = user.uid;
      print(1234);
      final AuthEntity authEntity = authModel.toEntity();
      return Right(authEntity);
    } else {
      print(111);
      return Left(ServerFailure(message: 'User creation failed'));
    }

    } catch (e) {
      print(e.toString());
    // Handle Firebase or other exceptions
    return Left(ServerFailure(message: e.toString()));
  }
  }
}
