import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../entities/classroom.dart';
import '../repository/clasroom_repository.dart';

class GetClassroomsUseCase
    implements UseCase<DataState<List<ClassroomEntity>>, void> {
  GetClassroomsUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<List<ClassroomEntity>>> call(void params) async {
    return _repository.getClassrooms();
  }
}
