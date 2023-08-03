import 'package:flutter/foundation.dart';

@immutable
class StudentEntity {
  final int age;
  final String email;
  final int id;
  final String name;

  const StudentEntity({
    required this.age,
    required this.email,
    required this.id,
    required this.name,
  });
}
