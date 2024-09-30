

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/profile/data/datasource/profile_datasource.dart';
import 'package:women_safty/futures/profile/domain/entity/profile_entity.dart';
import 'package:women_safty/futures/profile/domain/repository/profile_repository.dart';

class ProfileRepoImpl  implements ProfileRepository{
  final ProfileDatasource profileDatasource;
  ProfileRepoImpl ({
    required this.profileDatasource
  });
  @override
  Future<Either<Failure, ProfileEntity>> getProfile() {
    try {
      return profileDatasource.getProfile();
    } catch (e) {
      return Future.value(Left(ServerFailure(message: 'try again')));
    }
  }
  
  @override
  Future<Either<Failure, ProfileEntity>> profileUdate(String name) {
    try {
      return profileDatasource.profileUpdate(name);
    } catch (e) {
      return Future.value(Left(ServerFailure(message: 'try again')));
    }
  }
}