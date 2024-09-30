


import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/auth/domain/entity/auth_entity.dart';


abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> signInWithEmailAndPassword(String email, String password);
  Future<Either<Failure, bool>> signOut();
  Future<Either<Failure, AuthEntity>> signUp(String name,String email,String guardian, String phone, String password);
    
}