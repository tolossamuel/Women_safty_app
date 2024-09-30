

import 'package:women_safty/futures/rating/domain/entity/rating_entity.dart';

class RatingState {}

class RatingIntialState extends RatingState {}

class RatingLoadingState extends RatingState{}

class RatingErrorState extends RatingState {
  final String message;
  RatingErrorState({
    required this.message
  });
}

class RatingSuccessState extends RatingState {
  final RatingEntity ratingEntity;
  RatingSuccessState ({
    required this.ratingEntity
  });
}