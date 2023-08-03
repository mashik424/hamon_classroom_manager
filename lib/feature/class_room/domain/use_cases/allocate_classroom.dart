import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../params/allocate_classroom.dart';
import '../repository/clasroom_repository.dart';

class AllocateClassroomUseCase
    implements UseCase<DataState<dynamic>, AllocateClassroomParams> {
  AllocateClassroomUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<dynamic>> call(AllocateClassroomParams params) async {
    return _repository.allocateClassroomToSubject(
      classRoom: params.classRoom,
      subject: params.subject,
    );
  }
}
