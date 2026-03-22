import 'package:patient_project/core/result/data_result.dart';
import 'package:patient_project/features/auth/data/models/auth/response/auth_response_model.dart';

abstract class AuthRepository {
  Future<DataResult<AuthResponseModel>> login({required String identification, required String password});
  Future<DataResult<void>> logout();
}
