import 'package:flutter/foundation.dart';

@immutable
class RegistrationEntity {
  final int id;
  final int student;
  final int subject;

  const RegistrationEntity({
    required this.id,
    required this.student,
    required this.subject,
  });
}
