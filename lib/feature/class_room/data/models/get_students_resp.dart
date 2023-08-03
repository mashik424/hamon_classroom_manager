import 'package:flutter/material.dart';

import 'student.dart';

@immutable
class GetStudentsRespModel {
  const GetStudentsRespModel(this.students);
  final List<StudentModel> students;

  factory GetStudentsRespModel.fromJson(Map<String, dynamic> json) =>
      GetStudentsRespModel((json['students'] as List<dynamic>?)
              ?.map((e) => StudentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []);
}
