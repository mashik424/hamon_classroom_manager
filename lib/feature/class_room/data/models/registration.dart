import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/registration.dart';

@immutable
class RegistrationModel extends RegistrationEntity {
  const RegistrationModel({
    required super.id,
    required super.student,
    required super.subject,
  });

  @override
  String toString() {
    return 'Registration(id: $id, student: $student, subject: $subject)';
  }

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        id: json['id'] as int,
        student: json['student'] as int,
        subject: json['subject'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'student': student,
        'subject': subject,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RegistrationModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ student.hashCode ^ subject.hashCode;
}
