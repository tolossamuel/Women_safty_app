

import 'package:dartz/dartz.dart';
import 'package:women_safty/futures/guardina_homepage/domain/entity/guardian_entity.dart';
import 'package:women_safty/futures/guardina_homepage/domain/repository/guardian_repository.dart';

import '../../../../core/failure/failure.dart';

class GuardianUsecase {
  final GuardianRepository guardianRepository;

  GuardianUsecase({
    required this.guardianRepository
  });

  Future<Either<Failure,GuardianEntity>> getChildren() async{
    try {
      return guardianRepository.getChildren();
    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
  Future<Either<Failure,GuardianEntity>> getGardian() async{
    try {
      return guardianRepository.getGardian();
    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
}