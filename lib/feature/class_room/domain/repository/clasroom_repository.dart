import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/feature/class_room/domain/entities/registration.dart';

import '../entities/classroom.dart';
import '../entities/subject.dart';
import '../entities/student.dart';

abstract class ClassRoomRepository {
  Future<DataState<List<StudentEntity>>> getStudents();

  Future<DataState<StudentEntity>> getStudent(int id);

  Future<DataState<List<SubjectEntity>>> getSubjects();

  Future<DataState<SubjectEntity>> getSubject(int id);

  Future<DataState<List<ClassroomEntity>>> getClassrooms();

  Future<DataState<ClassroomEntity>> getClassroom(int id);

  Future<DataState<dynamic>> allocateClassroomToSubject({
    required int classRoom,
    required int subject,
  });

  Future<DataState<dynamic>> createRegistration({
    required int student,
    required int subject,
  });

  Future<DataState<List<RegistrationEntity>>> getRegistrations();

  Future<DataState<RegistrationEntity>> getRegistration(int id);

  Future<DataState<dynamic>> deleteRegistration(int id);
}
