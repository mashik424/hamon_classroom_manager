import 'package:classroom_manager/core/resources/data_state.dart';
import 'package:classroom_manager/core/usecases/usercase.dart';

import '../entities/student.dart';
import '../repository/clasroom_repository.dart';

class GetStudentUseCase implements UseCase<DataState<StudentEntity>, int> {
  GetStudentUseCase(this._repository);
  final ClassRoomRepository _repository;

  @override
  Future<DataState<StudentEntity>> call(int params) async {
    return _repository.getStudent(params);
  }
}
