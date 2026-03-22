import 'package:patient_project/core/base/network/network.dart';
import 'package:patient_project/core/error/error_handler.dart';
import 'package:patient_project/core/result/data_result.dart';
import 'package:patient_project/features/auth/data/models/auth/request/auth_request_model.dart';
import 'package:patient_project/features/auth/data/models/auth/response/auth_response_model.dart';
import 'package:patient_project/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final HttpClientService _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<DataResult<AuthResponseModel>> login({
    required String identification,
    required String password,
  }) async {
    try {
      final response = await _client.post<AuthResponseModel>(
        '/auth/login',
        data: AuthRequestModel(email: identification, password: password).toJson(),
        fromJson: AuthResponseModel.fromJson,
      );
      return Success(response);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<DataResult<void>> logout() async {
    try {
      await _client.post<void>('/auth/logout');
      return Success(null);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }
}
