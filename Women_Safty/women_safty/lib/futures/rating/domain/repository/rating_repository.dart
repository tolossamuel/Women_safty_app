

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/rating/domain/entity/rating_entity.dart';

abstract class RatingRepository {
  Future<Either<Failure,RatingEntity>> getRating();
  Future<Either<Failure,RatingEntity>> addRating(String titile, String detail,String star);
}