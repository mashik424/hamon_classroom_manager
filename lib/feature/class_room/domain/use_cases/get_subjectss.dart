import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../entities/subject.dart';
import '../repository/clasroom_repository.dart';

class GetSubjectsUseCase
    implements UseCase<DataState<List<SubjectEntity>>, void> {
  GetSubjectsUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<List<SubjectEntity>>> call(void params) async {
    return _repository.getSubjects();
  }
}
