import 'package:patient_project/core/error/app_exception.dart';
import 'package:patient_project/core/result/data_result.dart';
import 'package:patient_project/features/auth/data/models/auth/response/auth_response_model.dart';
import 'package:patient_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:patient_project/shared/services/connectivity_service.dart';
import 'package:patient_project/shared/storage/storage_service.dart';

class LoginUseCase {
  final AuthRepository _repository;
  final StorageService _storageService;
  final ConnectivityService _connectivityService;

  LoginUseCase(this._repository, this._storageService, this._connectivityService);

  Future<DataResult<AuthResponseModel>> call({
    required String identification,
    required String password,
  }) async {
    if (!await _connectivityService.hasConnection()) {
      return Failure(const NetworkException());
    }

    final result = await _repository.login(
      identification: identification,
      password: password,
    );
    if (result is Success<AuthResponseModel>) {
      await _storageService.write(StorageKeys.authToken, result.data.token);
    }
    return result;
  }
}
