

import 'package:women_safty/futures/auth/domain/entity/auth_entity.dart';

class AuthModel  extends AuthEntity{
  AuthModel({required super.email, required super.name, required super.guardian, required super.phone});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['email'],
      name: json['name'], guardian: '', phone: '',
      
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      email: email,
      name: name,
      guardian:  guardian,
      phone:  phone
    );
  }
}