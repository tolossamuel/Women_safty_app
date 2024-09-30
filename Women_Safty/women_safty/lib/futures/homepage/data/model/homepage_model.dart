

import 'package:women_safty/futures/homepage/domain/entity/homepage_entity.dart';

class HomepageModel  extends HomepageEntity{
  HomepageModel({required super.data});

  factory HomepageModel.fromJson(Map<String, dynamic> json) {
    return HomepageModel(
      data: json['data'],
    );
  }

 
  HomepageEntity toEntity() {
    return HomepageEntity(data: data);
  }
}