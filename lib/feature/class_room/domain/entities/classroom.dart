import 'package:flutter/foundation.dart';

@immutable
class ClassroomEntity {
  final int id;
  final String layout;
  final String name;
  final int size;
  final String subject;

  const ClassroomEntity({
    required this.id,
    required this.layout,
    required this.name,
    required this.size,
    required this.subject,
  });
}
