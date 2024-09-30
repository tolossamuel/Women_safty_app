

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/guardina_homepage/domain/entity/guardian_entity.dart';
import 'package:women_safty/futures/guardina_homepage/presentation/state/guardian_bloc/guardian_event.dart';

abstract class GuardianRepository {
  Future<Either<Failure,GuardianEntity>> getChildren();
  Future<Either<Failure,GuardianEntity>> getGardian();
}