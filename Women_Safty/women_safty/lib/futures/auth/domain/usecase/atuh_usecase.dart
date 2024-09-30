
import 'package:dartz/dartz.dart';

import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/auth/domain/entity/auth_entity.dart';
import 'package:women_safty/futures/auth/domain/repository/auth_repository.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase({
    required this.authRepository
  });


  Future<Either<Failure,AuthEntity>> signInWithEmailPassword(String email, String password){
    try {
      return authRepository.signInWithEmailAndPassword(email, password);
    } catch (e) {
      return Future.value(Left(ServerFailure(message: e.toString())));
    }
  }

  Future<Either<Failure, bool>> signOut(){
    try {
      return authRepository.signOut();
    } catch (e) {
      return Future.value(Left(ServerFailure(message:  e.toString())));
    }
  }

  Future<Either<Failure, AuthEntity>> signUp(String name,String email,String guardian, String phone, String password){
    try {
      return authRepository.signUp(name,email,guardian,phone,password);
    } catch (e) {
      return Future.value(Left(ServerFailure(message:  e.toString())));
    }
  }


 
}