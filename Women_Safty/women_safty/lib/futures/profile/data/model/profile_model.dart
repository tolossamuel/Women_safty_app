

import 'package:women_safty/futures/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.user
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: json['user'],
    );
  }
  ProfileEntity toEntity() {
    return ProfileEntity(
      user: user,
    );
  }
}