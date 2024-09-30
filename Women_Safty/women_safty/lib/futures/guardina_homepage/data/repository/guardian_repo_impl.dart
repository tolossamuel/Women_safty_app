
import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/guardina_homepage/data/datasource/guardian_datasource.dart';
import 'package:women_safty/futures/guardina_homepage/domain/entity/guardian_entity.dart';
import 'package:women_safty/futures/guardina_homepage/domain/repository/guardian_repository.dart';

class GuardianRepoImpl  implements GuardianRepository{
  final GuardianDatasource guardianDatasource;
  GuardianRepoImpl({
    required this.guardianDatasource
  });
  @override
  Future<Either<Failure, GuardianEntity>> getChildren() async{
    try {
      return guardianDatasource.getChildren();

    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
  
  @override
  Future<Either<Failure, GuardianEntity>> getGardian() async{
    try {
      return guardianDatasource.getGardian();

    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
}