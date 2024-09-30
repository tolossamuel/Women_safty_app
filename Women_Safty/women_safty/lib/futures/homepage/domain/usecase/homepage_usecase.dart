

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/homepage/domain/entity/homepage_entity.dart';
import 'package:women_safty/futures/homepage/domain/repository/homepage_repository.dart';

class HomepageUsecase {
  final HomepageRepository repository;

  HomepageUsecase(
    {
      required this.repository
    }
  );

  Future<Either<Failure,HomepageEntity>> getHomepage() async {
    return await repository.getHomepage();
  }
}