



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/profile/data/model/profile_model.dart';
import 'package:women_safty/futures/profile/domain/entity/profile_entity.dart';

abstract class ProfileDatasource {
  Future<Either<Failure,ProfileEntity>> getProfile();
  Future<Either<Failure, ProfileEntity>> profileUpdate(String name);
}


class ProfileDatasourceImpl extends ProfileDatasource {
  final FirebaseAuth firebaseAuth;
  ProfileDatasourceImpl({
    required  this.firebaseAuth
  });
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async{
    try {
       final User? currentUser = firebaseAuth.currentUser;

      if (currentUser == null) {
        return Future.value(Left(ServerFailure(message: 'User not authenticated')));
      }
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
        if (userData != null) {
          final ProfileModel profileModel = ProfileModel(user: userData);
          final ProfileEntity profileEntity = profileModel.toEntity();
          return Right(profileEntity);
        }
    }
    return Future.value(Left(ServerFailure(message: 'no user data found')));
    } catch (e) {
      return Future.value(Left(ServerFailure(message: 'try again')));
    }
  }
  
  
  @override
  Future<Either<Failure, ProfileEntity>> profileUpdate(String name) async {
    try {
      // Get current user
      final User? user = firebaseAuth.currentUser;

      if (user == null) {
        return Future.value(left(ServerFailure(message: "No authenticated user found")));
      }

      // Reference to the user's document in the 'users' collection
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Update only the 'name' field in Firestore
      await userDocRef.update({
        'name': name,
      });
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
        if (userData != null) {
          final ProfileModel profileModel = ProfileModel(user: userData);
          final ProfileEntity profileEntity = profileModel.toEntity();
          return Right(profileEntity);
        }
      }
    return Future.value(Left(ServerFailure(message: 'no user data found')));
    } catch (e) {
      return Future.value(left(ServerFailure(message: "try again")));
    }
  }

  
}