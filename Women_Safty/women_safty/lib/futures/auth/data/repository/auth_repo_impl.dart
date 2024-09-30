

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/auth/data/data_source/auth_data_source.dart';
import 'package:women_safty/futures/auth/domain/entity/auth_entity.dart';
import 'package:women_safty/futures/auth/domain/repository/auth_repository.dart';

class AuthRepoImpl  implements AuthRepository{
  final AuthDataSource authDataSource;

  AuthRepoImpl({required this.authDataSource});
  @override
  Future<Either<Failure, AuthEntity>> signInWithEmailAndPassword(String email, String password) {
    try {
      return authDataSource.signInWithEmailAndPassword(email, password);
    } catch (e) {
      return Future.value(Left(ServerFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() {
    try {
      return authDataSource.signOut();
    } catch (e) {
      return Future.value(Left(ServerFailure(message: e.toString())));
    }
  }
  @override
  Future<Either<Failure, AuthEntity>> signUp(String name,String email,String guardian, String phone, String password) {
    try {
      return authDataSource.signUp(name,email,guardian,phone,password);
    } catch (e) {
      return Future.value(Left(ServerFailure(message: e.toString())));
    }
  }
  
}