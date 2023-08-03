import 'package:flutter/foundation.dart';

@immutable
class AllocateClassroomParams {
  const AllocateClassroomParams({
    required this.classRoom,
    required this.subject,
  });
  final int classRoom;
  final int subject;
}
