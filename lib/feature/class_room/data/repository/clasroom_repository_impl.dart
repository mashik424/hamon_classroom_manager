import 'package:classroom_manager/core/error/app_exception.dart';
import 'package:classroom_manager/core/resources/data_state.dart';

import '../../domain/repository/clasroom_repository.dart';
import '../data_sources/remote/classroom_api_service.dart';
import '../models/classroom.dart';
import '../models/registration.dart';
import '../models/student.dart';
import '../models/subject.dart';

class ClassRoomRepositoryImpl implements ClassRoomRepository {
  final ClassroomApiService _apiService;

  ClassRoomRepositoryImpl(this._apiService);

  @override
  Future<DataState<dynamic>> allocateClassroomToSubject({
    required int classRoom,
    required int subject,
  }) async {
    try {
      final response = await _apiService.allocateClassRoomToSubject(
        classRoom: classRoom,
        subject: subject,
      );
      return DataSuccess(response);
    } catch (e) {
      return DataError(AppException(e));
    }
  }

  @override
  Future<DataState<dynamic>> createRegistration({
    required int student,
    required int subject,
  }) async {
    try {
      final response = await _apiService.createRegistration(
        student: student,
        subject: subject,
      );
      return DataSuccess(response);
    } catch (e) {
      return DataError(AppException(e));
    }
  }

  @override
  Future<DataState<dynamic>> deleteRegistration(int id) async {
    try {
      final response = await _apiService.deleteRegistration(id: id);
      return DataSuccess(response);
    } catch (e) {
      return DataError(AppException(e));
    }
  }

  @override
  Future<DataState<ClassroomModel>> getClassroom(int id) async {
    try {
      final response = await _apiService.getClassroom(id: id);
      return DataSuccess(response);
    } catch (e) {
      return DataError(AppException(e));
    }
  }

  @override
  Future<DataState<List<ClassroomModel>>> getClassrooms() async {
    try {
      final response = await _apiService.getClassrooms();
      return DataSuccess(response.classrooms);
    } catch (e) {
      return DataError(AppException(e));
    }
  }

  @override
  Future<DataState<RegistrationModel>> getRegistration(int id) async {
    try {
      final response = await _apiService.getRegistration(id: id);
      return DataSuccess(response);
    } catch (e) {
      return DataError(AppException(e));
    }
  }

  @override
  Future<DataState<List<RegistrationModel>>> getRegistrations() async {
    try {
      final response = await _apiService.getRegistrations();
      return DataSuccess(response.registrations);
    } catch (e) {
      return DataError(AppException(e));
    }
  }

  @override
  Future<DataState<StudentModel>> getStudent(int id) async {
    try {
      final response = await _apiService.getStudent(id: id);
      return DataSuccess(response);
    } catch (e) {
      return DataError(AppException(e));
    }
  }

  @override
  Future<DataState<List<StudentModel>>> getStudents() async {
    try {
      final response = await _apiService.getStudents();
      return DataSuccess(response.students);
    } catch (e) {
      return DataError(AppException(e));
    }
  }

  @override
  Future<DataState<SubjectModel>> getSubject(int id) async {
    try {
      final response = await _apiService.getSubject(id: id);
      return DataSuccess(response);
    } catch (e) {
      return DataError(AppException(e));
    }
  }

  @override
  Future<DataState<List<SubjectModel>>> getSubjects() async {
    try {
      final response = await _apiService.getSubjects();
      return DataSuccess(response.subjects);
    } catch (e) {
      return DataError(AppException(e));
    }
  }
}
