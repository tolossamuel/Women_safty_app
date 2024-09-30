

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/admin/data/datasource/admin_datasource.dart';
import 'package:women_safty/futures/admin/domain/entity/admin_entity.dart';
import 'package:women_safty/futures/admin/domain/repository/admin_repository.dart';

class AdminRepoImpl implements AdminRepository{
  final AdminDatasource adminDatasource;
  AdminRepoImpl({
    required this.adminDatasource
  });
  @override
  Future<Either<Failure, AdminEntity>> getGardianData() async{
    try{
      return adminDatasource.getGardianData();
    } catch (e) {
      return Left(ServerFailure(message: 'try agian'));
    }
    
  }

  @override
  Future<Either<Failure, AdminEntity>> getReviewData() async{
    try{
      return adminDatasource.getUserData();
    } catch (e) {
      return Left(ServerFailure(message: 'try agian'));
    }
  }

  @override
  Future<Either<Failure, AdminEntity>> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }
  
}