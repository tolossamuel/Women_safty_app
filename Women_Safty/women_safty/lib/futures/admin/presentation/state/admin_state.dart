

import 'package:women_safty/futures/admin/domain/entity/admin_entity.dart';

abstract class AdminState {}

class AdminIntialState extends AdminState{}

class AdminLoadingState extends AdminState{}

class AdminErrorState extends AdminState {
  final String message;
  AdminErrorState({
    required this.message
  });
}

class AdminSuccessState extends AdminState {
  final AdminEntity adminEntity;
  AdminSuccessState({
    required this.adminEntity
  });
}