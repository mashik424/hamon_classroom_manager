import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/subject.dart';

@immutable
class SubjectModel extends SubjectEntity {
  const SubjectModel({
    required super.credits,
    required super.id,
    required super.name,
    required super.teacher,
  });

  @override
  String toString() {
    return 'Subject(credits: $credits, id: $id, name: $name, teacher: $teacher)';
  }

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        credits: json['credits'] as int,
        id: json['id'] as int,
        name: json['name'] as String,
        teacher: json['teacher'] as String,
      );

  Map<String, dynamic> toJson() => {
        'credits': credits,
        'id': id,
        'name': name,
        'teacher': teacher,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SubjectModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      credits.hashCode ^ id.hashCode ^ name.hashCode ^ teacher.hashCode;
}
