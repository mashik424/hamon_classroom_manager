import 'package:flutter/material.dart';

import 'classroom.dart';

@immutable
class GetClassroomsRespModel {
  const GetClassroomsRespModel(this.classrooms);
  final List<ClassroomModel> classrooms;

  factory GetClassroomsRespModel.fromJson(Map<String, dynamic> json) =>
      GetClassroomsRespModel((json['classrooms'] as List<dynamic>?)
              ?.map((e) => ClassroomModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []);
}
