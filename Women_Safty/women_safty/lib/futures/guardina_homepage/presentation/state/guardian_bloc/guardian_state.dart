

import 'package:women_safty/futures/guardina_homepage/domain/entity/guardian_entity.dart';

abstract class GuardianState {}

class GuardianIntialState extends GuardianState{}

class GuardianLoadingState extends GuardianState{}

class GuardianErrorState extends GuardianState {
  final String message;

  GuardianErrorState ({
    required this.message
  });
}

class GuardianSuccessState extends GuardianState {
  final GuardianEntity guardianEntity;

  GuardianSuccessState({
    required this.guardianEntity
  });
}