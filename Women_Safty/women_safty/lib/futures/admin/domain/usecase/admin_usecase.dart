

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/admin/domain/entity/admin_entity.dart';
import 'package:women_safty/futures/admin/domain/repository/admin_repository.dart';

class AdminUsecase {
  final AdminRepository adminRepository;

  AdminUsecase({
    required this.adminRepository
  });

  Future<Either<Failure,AdminEntity>> getGardianData(){
    return adminRepository.getGardianData();
  }

  Future<Either<Failure,AdminEntity>> getReviewData(){
    return adminRepository.getReviewData();
  }
  Future<Either<Failure,AdminEntity>> getUserData(){
    return adminRepository.getUserData();
  }
}