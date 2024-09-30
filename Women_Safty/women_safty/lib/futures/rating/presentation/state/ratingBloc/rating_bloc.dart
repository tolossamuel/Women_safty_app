


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:women_safty/futures/rating/domain/usecase/rating_usecase.dart';
import 'package:women_safty/futures/rating/presentation/state/ratingBloc/rating_state.dart';

import 'rating_event.dart';

class RatingBloc  extends Bloc<RatingEvent,RatingState>{
  final RatingUsecase ratingUsecase;

  RatingBloc({required this.ratingUsecase}):super(RatingIntialState()) {
    String title = '';
    String detail = '';
    String star = '';
    on<GetRating> (
      (event,emit) async {
        emit(RatingLoadingState());
        final result = await ratingUsecase.getRating();
        result.fold(
          (left) => emit(RatingErrorState(message: left.message)),
          (right) => emit(RatingSuccessState(ratingEntity: right))
        );
      }
    );

    on<RatingInput>(
      (event,emit) {
        if (event.indicatore == 1) {
          title = event.text;
        } else if (event.indicatore == 2){
          detail = event.text;
        } else {
          star = event.text;
        }
        emit(state);
      }
    );

    on<AddRating>(
      (event,emit) async {
        if (title.isEmpty || detail.isEmpty || star.isEmpty) {
          emit(RatingErrorState(message: 'invalid input'));
        } else {
          emit(RatingLoadingState());
          final result = await ratingUsecase.addRating(title, detail,star);
          result.fold(
            (l) => emit(RatingErrorState(message: 'try again')), 
            (r) => emit(RatingSuccessState(ratingEntity: r)));
        }

      }
    );
  }
}