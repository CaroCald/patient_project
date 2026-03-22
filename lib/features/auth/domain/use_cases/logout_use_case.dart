import 'package:patient_project/core/result/data_result.dart';
import 'package:patient_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:patient_project/shared/storage/storage_service.dart';

class LogoutUseCase {
  final AuthRepository _repository;
  final StorageService _storageService;

  LogoutUseCase(this._repository, this._storageService);

  Future<DataResult<void>> call() async {
    final result = await _repository.logout();
    if (result is Success<void>) {
      await _storageService.delete(StorageKeys.authToken);
    }
    return result;
  }
}
