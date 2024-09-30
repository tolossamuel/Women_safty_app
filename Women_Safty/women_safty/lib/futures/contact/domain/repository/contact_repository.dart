

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/contact/domain/entity/contact_entity.dart';

abstract class ContactRepository {
  Future<Either<Failure, ContactEntity>> getContact();
  Future<Either<Failure, ContactEntity>> addContact(String contact,String phone);
}