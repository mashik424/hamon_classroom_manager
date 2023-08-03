import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/student.dart';

@immutable
class StudentModel extends StudentEntity {
  const StudentModel({
    required super.age,
    required super.email,
    required super.id,
    required super.name,
  });

  @override
  String toString() {
    return 'Student(age: $age, email: $email, id: $id, name: $name)';
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        age: json['age'] as int,
        email: json['email'] as String,
        id: json['id'] as int,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'age': age,
        'email': email,
        'id': id,
        'name': name,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! StudentModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      age.hashCode ^ email.hashCode ^ id.hashCode ^ name.hashCode;
}
