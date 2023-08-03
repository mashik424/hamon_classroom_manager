import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../entities/registration.dart';
import '../repository/clasroom_repository.dart';

class GetRegistrationUseCase
    implements UseCase<DataState<RegistrationEntity>, int> {
  GetRegistrationUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<RegistrationEntity>> call(int params) async {
    return _repository.getRegistration(params);
  }
}
