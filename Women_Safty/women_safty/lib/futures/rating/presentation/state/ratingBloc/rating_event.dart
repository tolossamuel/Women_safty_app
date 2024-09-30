

abstract class RatingEvent {}

class GetRating extends RatingEvent{}

class AddRating extends RatingEvent{}

class RatingInput extends RatingEvent{
  final int indicatore;
  final String text;

  RatingInput({
    required this.indicatore,
    required this.text,
  });
}