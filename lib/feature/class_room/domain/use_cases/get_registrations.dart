import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../entities/registration.dart';
import '../repository/clasroom_repository.dart';

class GetRegistrationsUseCase
    implements UseCase<DataState<List<RegistrationEntity>>, void> {
  GetRegistrationsUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<List<RegistrationEntity>>> call(void params) async {
    return _repository.getRegistrations();
  }
}
