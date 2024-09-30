

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/contact/data/datasource/contact_datasource.dart';
import 'package:women_safty/futures/contact/domain/entity/contact_entity.dart';
import 'package:women_safty/futures/contact/domain/repository/contact_repository.dart';

class ContactRepoImpl  implements ContactRepository{
  final ContactDatasource contactDatasource;
  ContactRepoImpl({required this.contactDatasource});
  @override
  Future<Either<Failure, ContactEntity>> addContact(String contact,String phone) {
    try {
      return contactDatasource.addContact(contact,phone);
    } catch (e) {
      return Future.value(left(ServerFailure(message: 'try again')));
    }
  }

  @override
  Future<Either<Failure, ContactEntity>> getContact() {
    try {
      return contactDatasource.getContact();
    } catch (e) {
      return Future.value(left(ServerFailure(message: 'try again')));
    }
  }
}