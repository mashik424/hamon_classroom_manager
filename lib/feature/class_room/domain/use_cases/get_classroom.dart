import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../entities/classroom.dart';
import '../repository/clasroom_repository.dart';

class GetClassroomUseCase implements UseCase<DataState<ClassroomEntity>, int> {
  GetClassroomUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<ClassroomEntity>> call(int params) async {
    return _repository.getClassroom(params);
  }
}
