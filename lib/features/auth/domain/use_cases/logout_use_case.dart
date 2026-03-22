import 'package:patient_project/core/result/data_result.dart';
import 'package:patient_project/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<DataResult<void>> call() => _repository.logout();
}
