import 'package:classroom_manager/feature/class_room/domain/entities/classroom.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class ClassroomModel extends ClassroomEntity {
  const ClassroomModel({
    required super.id,
    required super.layout,
    required super.name,
    required super.size,
    required super.subject,
  });

  @override
  String toString() {
    return 'Classroom(id: $id, layout: $layout, name: $name, size: $size, subject: $subject)';
  }

  factory ClassroomModel.fromJson(Map<String, dynamic> json) => ClassroomModel(
        id: json['id'] as int,
        layout: json['layout'] as String,
        name: json['name'] as String,
        size: json['size'] as int,
        subject: json['subject'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'layout': layout,
        'name': name,
        'size': size,
        'subject': subject,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ClassroomModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      layout.hashCode ^
      name.hashCode ^
      size.hashCode ^
      subject.hashCode;
}
