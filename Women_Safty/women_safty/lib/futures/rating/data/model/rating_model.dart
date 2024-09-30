

import 'package:women_safty/futures/rating/domain/entity/rating_entity.dart';

class RatingModel  extends RatingEntity{
  RatingModel({required super.rating});
  
  // from json
  factory RatingModel.fromJson(dynamic data) => RatingModel(rating: data['ragin']);

  // to entity

  RatingEntity toEntity() => RatingEntity(rating: rating);
}