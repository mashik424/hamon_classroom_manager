import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../entities/subject.dart';
import '../repository/clasroom_repository.dart';

class GetSubjectUseCase implements UseCase<DataState<SubjectEntity>, int> {
  GetSubjectUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<SubjectEntity>> call(int params) async {
    return _repository.getSubject(params);
  }
}
