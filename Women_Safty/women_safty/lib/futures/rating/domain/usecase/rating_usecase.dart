

import 'package:dartz/dartz.dart';
import 'package:women_safty/futures/rating/domain/repository/rating_repository.dart';

import '../../../../core/failure/failure.dart';
import '../entity/rating_entity.dart';

class RatingUsecase {
  final RatingRepository ratingRepository;

  RatingUsecase ({
    required this.ratingRepository
  });

  Future<Either<Failure,RatingEntity>> getRating(){
    try {
      return ratingRepository.getRating();
    } catch (e) {
      return Future.value(Left(ServerFailure(message :'try again')));
    }
  }
  Future<Either<Failure,RatingEntity>> addRating(String titile, String detail,String star){
    try {
      return ratingRepository.addRating(titile,detail,star);
    } catch (e) {
      return Future.value(Left(ServerFailure(message :'try again')));
    }
  }
}