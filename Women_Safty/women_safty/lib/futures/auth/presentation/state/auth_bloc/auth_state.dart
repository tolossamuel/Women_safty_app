

import 'package:women_safty/futures/auth/domain/entity/auth_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthEntity authEntity;

  AuthSuccess({required this.authEntity});
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}

class AuthLogoutSeccuss extends AuthState {
  final bool logedout;

  AuthLogoutSeccuss({required this.logedout});
}
class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}