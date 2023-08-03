import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:classroom_manager/feature/class_room/data/data_sources/remote/classroom_api_service.dart';
import 'package:classroom_manager/feature/class_room/data/repository/clasroom_repository_impl.dart';
import 'package:classroom_manager/feature/class_room/domain/repository/clasroom_repository.dart';

final gi = GetIt.instance;

Future<void> initializeDependancies() async {
  gi.registerSingleton<Dio>(Dio());

  gi.registerSingleton<ClassroomApiService>(ClassroomApiService(gi()));

  gi.registerSingleton<ClassRoomRepository>(ClassRoomRepositoryImpl(gi()));
}
