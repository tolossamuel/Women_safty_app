
import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/profile/domain/entity/profile_entity.dart';
import 'package:women_safty/futures/profile/domain/repository/profile_repository.dart';

class ProfileUsecase {
  final ProfileRepository profileRepository;

  ProfileUsecase({required this.profileRepository});

  Future<Either<Failure,ProfileEntity>> getProfile() async {
    try {
      return await profileRepository.getProfile();
    } catch (e) {
      return Future.value(Left(ServerFailure(message: 'try again')));
    }
  }

  Future<Either<Failure,ProfileEntity>> updateProfile(String name) async {
    try {
      return await profileRepository.profileUdate(name);
    } catch (e) {
      return Future.value(Left(ServerFailure(message: 'try again')));
    }
  }

  
}