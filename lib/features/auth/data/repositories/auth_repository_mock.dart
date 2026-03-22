import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:patient_project/core/error/error_handler.dart';
import 'package:patient_project/core/result/data_result.dart';
import 'package:patient_project/features/auth/data/models/auth/response/auth_response_model.dart';
import 'package:patient_project/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryMock implements AuthRepository {
  @override
  Future<DataResult<AuthResponseModel>> login({
    required String identification,
    required String password,
  }) async {
    try {
      final jsonString = await rootBundle.loadString('assets/mock/auth_response.json');
      return Success(AuthResponseModel.fromJson(jsonDecode(jsonString)));
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<DataResult<void>> logout() async => Success(null);
}
