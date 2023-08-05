import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:classroom_manager/core/constants/constants.dart';

import '../../models/classroom.dart';
import '../../models/get_classrooms_resp.dart';
import '../../models/get_registrations_resp.dart';
import '../../models/get_subjects_resp.dart';
import '../../models/get_students_resp.dart';
import '../../models/registration.dart';
import '../../models/student.dart';
import '../../models/subject.dart';

part 'classroom_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class ClassroomApiService {
  factory ClassroomApiService(Dio dio) = _ClassroomApiService;

  @GET('/students')
  Future<GetStudentsRespModel> getStudents({
    @Query('api_key') String apiKey = '3990C',
  });

  @GET('/students/{id}')
  Future<StudentModel> getStudent({
    @Query('api_key') String apiKey = '3990C',
    @Path('id') required int id,
  });

  @GET('/subjects')
  Future<GetSubjectsRespModel> getSubjects({
    @Query('api_key') String apiKey = '3990C',
  });

  @GET('/subjects/{id}')
  Future<SubjectModel> getSubject({
    @Query('api_key') String apiKey = '3990C',
    @Path('id') required int id,
  });

  @GET('/classrooms')
  Future<GetClassroomsRespModel> getClassrooms({
    @Query('api_key') String apiKey = '3990C',
  });

  @GET('/classrooms/{id}')
  Future<ClassroomModel> getClassroom({
    @Query('api_key') String apiKey = '3990C',
    @Path('id') required int id,
  });

  @PATCH('/classrooms/{id}')
  Future<dynamic> allocateClassRoomToSubject({
    @Query('api_key') String apiKey = '3990C',
    @Path('id') required int classRoom,
    @Query('subject') required int subject,
  });

  @GET('/registration')
  Future<GetRegistrationsRespModel> getRegistrations({
    @Query('api_key') String apiKey = '3990C',
  });

  @GET('/registration/{id}')
  Future<RegistrationModel> getRegistration({
    @Query('api_key') String apiKey = '3990C',
    @Path('id') required int id,
  });

  @POST('/registration/')
  @MultiPart()
  Future<dynamic> createRegistration({
    @Query('api_key') String apiKey = '3990C',
    @Part(name: 'student') required int student,
    @Part(name: 'subject') required int subject,
  });

  @DELETE('/registration/{id}')
  Future<dynamic> deleteRegistration({
    @Query('api_key') String apiKey = '3990C',
    @Path('id')required int id,
  });
}
