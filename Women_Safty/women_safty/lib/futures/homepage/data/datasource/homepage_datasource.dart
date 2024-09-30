

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/homepage/data/model/homepage_model.dart';
import 'package:women_safty/futures/homepage/domain/entity/homepage_entity.dart';

abstract class HomepageDatasource {
  Future<Either<Failure,HomepageEntity>> getHomepage();
}

class HomepageDatasourceImpl implements HomepageDatasource {
  final FirebaseAuth firebaseAuth;
  HomepageDatasourceImpl({
    required  this.firebaseAuth
  });
  @override

  Future<Either<Failure, HomepageEntity>> getHomepage() async{
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('homepage').get();
      List<dynamic> homepageData = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Example structure of each document
      return {
        'imageUrl': data['imageUrl'],
        'websiteUrl': data['websiteUrl'],
        'topicName': data['topicName'],
     // If you have ratings
      };
    }).toList();
    final HomepageModel homepageModel = HomepageModel(data: homepageData);
    final HomepageEntity homepageEntity = homepageModel.toEntity();
    return Right(homepageEntity);
    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
}