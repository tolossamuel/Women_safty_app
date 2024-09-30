

import 'package:women_safty/futures/contact/domain/entity/contact_entity.dart';

class ContactModel extends ContactEntity{
  ContactModel({required super.contact, required super.userId});
  

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      contact: json['contact'],
      userId: json['userId'],
    );
  }
  
  // to entity
  ContactEntity toEntity() {
    return ContactEntity(
      contact: contact,
      userId: userId,
    );
  }
}