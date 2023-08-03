import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../params/create_registration.dart';
import '../repository/clasroom_repository.dart';

class AllocateClassroomUseCase
    implements UseCase<DataState<dynamic>, CreateRegistrationParams> {
  AllocateClassroomUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<dynamic>> call(CreateRegistrationParams params) async {
    return _repository.createRegistration(
      student: params.student,
      subject: params.subject,
    );
  }
}
