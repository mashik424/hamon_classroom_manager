import 'package:flutter/material.dart';

import 'subject.dart';

@immutable
class GetSubjectsRespModel {
  const GetSubjectsRespModel(this.subjects);
  final List<SubjectModel> subjects;

  factory GetSubjectsRespModel.fromJson(Map<String, dynamic> json) =>
      GetSubjectsRespModel((json['subjects'] as List<dynamic>?)
              ?.map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          []);
}
