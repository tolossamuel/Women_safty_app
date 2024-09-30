


import 'package:women_safty/futures/profile/domain/entity/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}
class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState({required this.message});
}
class ProfileLoaded extends ProfileState {
  final ProfileEntity profileEntity;

  ProfileLoaded({required this.profileEntity});
}

