import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:classroom_manager/core/error/app_exception.dart';
import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/util/snackbar.dart';
import 'package:classroom_manager/di.dart';
import 'package:classroom_manager/feature/class_room/data/models/subject.dart';
import 'package:classroom_manager/feature/class_room/domain/repository/clasroom_repository.dart';
import 'package:classroom_manager/feature/class_room/domain/use_cases/get_subject.dart';
import 'package:classroom_manager/feature/class_room/domain/use_cases/get_subjectss.dart';

final subjectsNotifier = ChangeNotifierProvider<SubjectsNotifier>(
  (ref) => SubjectsNotifier(gi()),
);

class SubjectsNotifier extends ChangeNotifier {
  SubjectsNotifier(this.repository);

  final ClassRoomRepository repository;

  List<SubjectModel> subjects = [];

  Future<void> getSubjects(BuildContext context) async {
    subjects.clear();
    notifyListeners();
    final result = await GetSubjectsUseCase(repository).call(null);
    if (result is DataSuccess) {
      if (result.data is List<SubjectModel>) {
        subjects.addAll(result.data as List<SubjectModel>);
        if (subjects.isEmpty) {
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

  Future<SubjectModel> getSubject(int id) async {
    final result = await GetSubjectUseCase(repository).call(id);
    if (result is DataSuccess && result.data is SubjectModel) {
      return result.data as SubjectModel;
    } else if (result is DataError) {
      throw result.error!;
    }
    throw AppException('Something went wrong');
  }
}
