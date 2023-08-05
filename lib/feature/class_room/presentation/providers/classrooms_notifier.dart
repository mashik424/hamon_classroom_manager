import 'package:classroom_manager/feature/class_room/domain/use_cases/allocate_classroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:classroom_manager/core/error/app_exception.dart';
import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/util/snackbar.dart';
import 'package:classroom_manager/di.dart';
import 'package:classroom_manager/feature/class_room/data/models/classroom.dart';
import 'package:classroom_manager/feature/class_room/domain/repository/clasroom_repository.dart';
import 'package:classroom_manager/feature/class_room/domain/use_cases/get_classroom.dart';
import 'package:classroom_manager/feature/class_room/domain/use_cases/get_classrooms.dart';

import '../../domain/params/allocate_classroom.dart';

final classroomsNotifier = ChangeNotifierProvider<ClassroomsNotifier>(
  (ref) => ClassroomsNotifier(gi()),
);

class ClassroomsNotifier extends ChangeNotifier {
  ClassroomsNotifier(this.repository);

  final ClassRoomRepository repository;

  List<ClassroomModel> classrooms = [];

  bool allocating = false;

  Future<void> getClasssrooms(BuildContext context) async {
    classrooms.clear();
    notifyListeners();
    final result = await GetClassroomsUseCase(repository).call(null);
    if (result is DataSuccess) {
      if (result.data is List<ClassroomModel>) {
        classrooms.addAll(result.data as List<ClassroomModel>);
        if (classrooms.isEmpty) {
          // ignore: use_build_context_synchronously
          showSnackBar(context, message: 'No classrooms');
        }
      }
    } else if (result is DataError) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, message: result.toString(), isError: true);
    }
    notifyListeners();
  }

  Future<ClassroomModel> getClasssroom(int id) async {
    final result = await GetClassroomUseCase(repository).call(id);
    if (result is DataSuccess && result.data is ClassroomModel) {
      return result.data as ClassroomModel;
    } else if (result is DataError) {
      throw result.error!;
    }
    throw AppException('Something went wrong');
  }

  Future<bool> assignSubject(
    BuildContext context, {
    required int classRoom,
    required int subject,
  }) async {
    allocating = true;
    notifyListeners();
    final result = await AllocateClassroomUseCase(repository)
        .call(AllocateClassroomParams(
      classRoom: classRoom,
      subject: subject,
    ));

    if (result is DataSuccess) {
      // ignore: use_build_context_synchronously
      getClasssrooms(context);
      return true;
    } else if (result is DataError) {
      allocating = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
      showSnackBar(context, message: result.error.toString(), isError: true);
      return false;
    }
    return false;
  }
}
