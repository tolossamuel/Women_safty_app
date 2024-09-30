

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/admin/domain/entity/admin_entity.dart';

abstract class AdminRepository {
  Future<Either<Failure,AdminEntity>> getGardianData();
  Future<Either<Failure,AdminEntity>> getUserData();
  Future<Either<Failure,AdminEntity>> getReviewData();
}