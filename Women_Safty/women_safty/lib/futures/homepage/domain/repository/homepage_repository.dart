

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/homepage/domain/entity/homepage_entity.dart';

abstract class HomepageRepository {
  Future<Either<Failure, HomepageEntity>> getHomepage();
}