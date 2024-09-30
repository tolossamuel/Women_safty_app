

import 'package:dartz/dartz.dart';
import 'package:women_safty/core/failure/failure.dart';
import 'package:women_safty/futures/contact/domain/entity/contact_entity.dart';
import 'package:women_safty/futures/contact/domain/repository/contact_repository.dart';

class ContactUsecase {
  final ContactRepository contactRepository;

  ContactUsecase({required this.contactRepository});

  Future<Either<Failure,ContactEntity>> getContact() async {
    try {
      return await contactRepository.getContact();
    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }

  Future<Either<Failure,ContactEntity>> addContact(String contact,String phone) async {
    try {
      return await contactRepository.addContact(contact,phone);
    } catch (e) {
      return Left(ServerFailure(message: 'try again'));
    }
  }
}