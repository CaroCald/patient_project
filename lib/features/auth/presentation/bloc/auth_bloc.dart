import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:patient_project/core/result/data_result.dart';
import 'package:patient_project/features/auth/data/models/auth/response/auth_response_model.dart';
import 'package:patient_project/features/auth/domain/use_cases/login_use_case.dart';
import 'package:patient_project/features/auth/domain/use_cases/logout_use_case.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  late TextEditingController identificationController;
  late TextEditingController passwordController;

  AuthBloc(this._loginUseCase, this._logoutUseCase)
      : super(const AuthState()) {
  
    on<_LoginRequested>(_onLoginRequested);
    on<_LogoutRequested>(_onLogoutRequested);
  }

  void init() {
    identificationController = TextEditingController();
    passwordController = TextEditingController();
  }
  void clearControllers() {
    identificationController.clear();
    passwordController.clear();
  }

  @override
  Future<void> close() {
    identificationController.dispose();
    passwordController.dispose();
    return super.close();
  }

  FutureOr<void> _onLoginRequested(
      _LoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _loginUseCase(
      identification: identificationController.text.trim(),
      password: passwordController.text,
    );
    if (result is Success<AuthResponseModel>) {
      emit(state.copyWith(status: AuthStatus.authenticated, authModel: result.data));
    } else if (result is Failure<AuthResponseModel>) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: result.exception.message));
    }
  }

  FutureOr<void> _onLogoutRequested(
      _LogoutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _logoutUseCase();
    if (result is Success<void>) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, authModel: null));
    } else if (result is Failure<void>) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: result.exception.message));
    }
  }
}
