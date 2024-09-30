

import 'package:women_safty/futures/homepage/domain/entity/homepage_entity.dart';

abstract class HomepageState {}

class HomepageInitial extends HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageLoaded extends HomepageState {
  final HomepageEntity homepageEntity;

  HomepageLoaded({required this.homepageEntity});
}

class HomepageError extends HomepageState {
  final String message;

  HomepageError({required this.message});
}