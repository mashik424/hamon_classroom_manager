import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../entities/student.dart';
import '../repository/clasroom_repository.dart';

class GetStudentsUseCase
    implements UseCase<DataState<List<StudentEntity>>, void> {
  GetStudentsUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<List<StudentEntity>>> call(void params) async {
    return _repository.getStudents();
  }
}
