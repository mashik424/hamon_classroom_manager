import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../repository/clasroom_repository.dart';

class DeleteRegistrationUseCase implements UseCase<DataState<dynamic>, int> {
  DeleteRegistrationUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<dynamic>> call(int params) async {
    return _repository.deleteRegistration(params);
  }
}
