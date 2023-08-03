import 'package:flutter/foundation.dart';

@immutable
class SubjectEntity {
  final int credits;
  final int id;
  final String name;
  final String teacher;

  const SubjectEntity({
    required this.credits,
    required this.id,
    required this.name,
    required this.teacher,
  });
}
