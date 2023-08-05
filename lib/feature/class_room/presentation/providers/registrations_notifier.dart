import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:classroom_manager/core/error/app_exception.dart';
import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/util/snackbar.dart';
import 'package:classroom_manager/di.dart';
import 'package:classroom_manager/feature/class_room/data/models/registration.dart';
import 'package:classroom_manager/feature/class_room/data/models/student.dart';
import 'package:classroom_manager/feature/class_room/domain/params/create_registration.dart';
import 'package:classroom_manager/feature/class_room/domain/repository/clasroom_repository.dart';
import 'package:classroom_manager/feature/class_room/domain/use_cases/create_registration.dart';
import 'package:classroom_manager/feature/class_room/domain/use_cases/delete_registration.dart';
import 'package:classroom_manager/feature/class_room/domain/use_cases/get_registration.dart';
import 'package:classroom_manager/feature/class_room/domain/use_cases/get_registrations.dart';

import 'students_notifier.dart';

final registrationsNotifier = ChangeNotifierProvider<RegistrationsNotifier>(
  (ref) => RegistrationsNotifier(gi(), ref),
);

class RegistrationsNotifier extends ChangeNotifier {
  RegistrationsNotifier(this.repository, this.ref);

  final ClassRoomRepository repository;
  final ChangeNotifierProviderRef ref;

  List<RegistrationModel> registrations = [];

  bool creating = false;
  bool deleting = false;

  Future<void> getRegistrations(
    BuildContext context, {
    bool silent = false,
  }) async {
    if (!silent) {
      registrations.clear();
    }
    notifyListeners();
    final result = await GetRegistrationsUseCase(repository).call(null);

    if (result is DataSuccess) {
      if (result.data is List<RegistrationModel>) {
        registrations.clear();
        registrations.addAll(result.data as List<RegistrationModel>);
        if (registrations.isEmpty) {
          // ignore: use_build_context_synchronously
          showSnackBar(context, message: 'No registrations');
        }
      }
    } else if (result is DataError) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, message: result.toString(), isError: true);
    }
    notifyListeners();
  }

  Map<int, StudentModel> studentsOf({required int subject}) {
    final students = ref.read(studentsNotifier).students;
    if (registrations.isEmpty || students.isEmpty) return {};

    final map = <int, StudentModel>{};

    for (final registration in registrations) {
      try {
        map.putIfAbsent(
          registration.id,
          () => students.firstWhere(
            (element) => element.id == registration.student,
          ),
        );
      } catch (e) {
        //
      }
    }

    return map;
  }

  Future<RegistrationModel> getRegistration(int id) async {
    final result = await GetRegistrationUseCase(repository).call(id);
    if (result is DataSuccess && result.data is RegistrationModel) {
      return result.data as RegistrationModel;
    } else if (result is DataError) {
      throw result.error!;
    }
    throw AppException('Something went wrong');
  }

  Future<bool> createRegistration(
    BuildContext context, {
    required CreateRegistrationParams params,
  }) async {
    creating = true;
    notifyListeners();

    final result = await CreateRegistrationUseCase(repository).call(params);

    if (result is DataSuccess) {
      creating = false;
      // ignore: use_build_context_synchronously
      getRegistrations(context, silent: true);
      return true;
    } else if (result is DataError) {
      creating = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
      showSnackBar(context, message: result.error.toString(), isError: true);
      return false;
    }
    return false;
  }

  Future<bool> deleteRegistration(
    BuildContext context, {
    required int id,
  }) async {
    deleting = true;
    notifyListeners();

    final result = await DeleteRegistrationUseCase(repository).call(id);

    if (result is DataSuccess) {
      deleting = false;
      // ignore: use_build_context_synchronously
      getRegistrations(context, silent: true);
      return true;
    } else if (result is DataError) {
      deleting = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
      showSnackBar(context, message: result.error.toString(), isError: true);
      return false;
    }
    return false;
  }
}
