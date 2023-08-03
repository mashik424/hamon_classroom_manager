import 'package:flutter/material.dart';

@immutable
class CreateRegistrationParams {
  const CreateRegistrationParams({
    required this.student,
    required this.subject,
  });
  final int student;
  final int subject;
}
