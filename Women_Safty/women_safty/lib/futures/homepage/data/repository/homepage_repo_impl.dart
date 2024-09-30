

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/homepage/data/datasource/homepage_datasource.dart';
import 'package:women_safty/futures/homepage/domain/entity/homepage_entity.dart';
import 'package:women_safty/futures/homepage/domain/repository/homepage_repository.dart';

class HomepageRepoImpl  implements HomepageRepository{
  final HomepageDatasource datasource;
  HomepageRepoImpl({
    required this.datasource
  });
  @override
  Future<Either<Failure, HomepageEntity>> getHomepage() {
    try {
      return datasource.getHomepage();
    } catch (e) {
      return Future.value(Left(ServerFailure(message: 'try again')));
    }
  }
  
}