import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:classroom_manager/core/error/app_exception.dart';
import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/util/snackbar.dart';
import 'package:classroom_manager/di.dart';
import 'package:classroom_manager/feature/class_room/data/models/student.dart';
import 'package:classroom_manager/feature/class_room/domain/repository/clasroom_repository.dart';
import 'package:classroom_manager/feature/class_room/domain/use_cases/get_student.dart';
import 'package:classroom_manager/feature/class_room/domain/use_cases/get_students.dart';

final studentsNotifier = ChangeNotifierProvider<StudentsNotifier>(
  (ref) => StudentsNotifier(gi()),
);

class StudentsNotifier extends ChangeNotifier {
  StudentsNotifier(this.repository);

  final ClassRoomRepository repository;

  List<StudentModel> students = [];

  Future<void> getStudents(BuildContext context) async {
    students.clear();
    notifyListeners();
    final result = await GetStudentsUseCase(repository).call(null);
    if (result is DataSuccess) {
      if (result.data is List<StudentModel>) {
        students.addAll(result.data as List<StudentModel>);
        if (students.isEmpty) {
          // ignore: use_build_context_synchronously
          showSnackBar(context, message: 'No students');
        }
      }
    } else if (result is DataError) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, message: result.toString(), isError: true);
    }
    notifyListeners();
  }

  Future<StudentModel> getStudent(int id) async {
    final result = await GetStudentUseCase(repository).call(id);
    if (result is DataSuccess && result.data is StudentModel) {
      return result.data as StudentModel;
    } else if (result is DataError) {
      throw result.error!;
    }
    throw AppException('Something went wrong');
  }
}
