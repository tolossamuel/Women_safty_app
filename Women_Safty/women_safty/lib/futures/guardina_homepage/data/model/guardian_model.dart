

import 'package:women_safty/futures/guardina_homepage/domain/entity/guardian_entity.dart';

class GuardianModel extends GuardianEntity {
  GuardianModel({required super.children});

  factory GuardianModel.fromJson(dynamic data) => GuardianModel(children: data['data']);

  GuardianEntity toEntity() => GuardianEntity(children: children);
}