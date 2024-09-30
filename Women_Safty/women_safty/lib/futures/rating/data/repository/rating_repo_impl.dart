

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/rating/data/datasource/rating_datasource.dart';
import 'package:women_safty/futures/rating/domain/entity/rating_entity.dart';
import 'package:women_safty/futures/rating/domain/repository/rating_repository.dart';

class RatingRepoImpl extends RatingRepository{
  final RatingDatasource ratingDatasource;

  RatingRepoImpl({
    required this.ratingDatasource
  });
  @override
  Future<Either<Failure, RatingEntity>> getRating() async{
    try {
      return ratingDatasource.getRating();
    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
  @override
  Future<Either<Failure,RatingEntity>> addRating(String titile, String detail,String star) async{
    try {
      return ratingDatasource.addRating(titile,detail,star);
    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
}