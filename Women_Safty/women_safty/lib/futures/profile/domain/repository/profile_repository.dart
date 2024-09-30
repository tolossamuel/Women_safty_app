

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure,ProfileEntity>> getProfile();
  Future<Either<Failure,ProfileEntity>> profileUdate(String name);
}