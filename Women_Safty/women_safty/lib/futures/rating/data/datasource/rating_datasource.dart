
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/rating/data/model/rating_model.dart';
import 'package:women_safty/futures/rating/domain/entity/rating_entity.dart';

abstract class RatingDatasource {
  Future<Either<Failure,RatingEntity>> getRating();
  Future<Either<Failure,RatingEntity>> addRating(String title, String detail,String star);
}

class RatingDatasourceImpl implements RatingDatasource{
  final FirebaseAuth firebaseAuth;

  RatingDatasourceImpl({
    required this.firebaseAuth
  });
  @override
  Future<Either<Failure, RatingEntity>> getRating() async{
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('rating').get();
      List<dynamic> homepageData = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Example structure of each document
      return {
        'title': data['title'],
        'detail': data['detail'],
        'star' : data['star']
     // If you have ratings
      };
    }).toList();
    final RatingModel homepageModel = RatingModel(rating: homepageData);
    final RatingEntity homepageEntity = homepageModel.toEntity();
    return Right(homepageEntity);
    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }

  @override
  Future<Either<Failure, RatingEntity>> addRating(String title, String detail,String star) async{
    try {
      
      CollectionReference ratingCollection = FirebaseFirestore.instance.collection('rating');
      await ratingCollection.add({
        'title': title,
        'detail': detail,
        'star' : star
        
      });
      print(1231114);
      return getRating();
    } catch (e) {
     
      return Left(ServerFailure(message: 'try again'));
    }
    
  }
  
}