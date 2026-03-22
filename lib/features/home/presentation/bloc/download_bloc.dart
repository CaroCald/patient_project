import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:patient_project/core/result/data_result.dart';
import 'package:patient_project/features/home/domain/use_cases/download_pdf_use_case.dart';

part 'download_bloc.freezed.dart';
part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final DownloadPdfUseCase _downloadPdfUseCase;

  DownloadBloc(this._downloadPdfUseCase) : super(const DownloadState()) {
    on<_DownloadRequested>(_onDownloadRequested);
  }

  FutureOr<void> _onDownloadRequested(
      _DownloadRequested event, Emitter<DownloadState> emit) async {
    emit(state.copyWith(status: DownloadStatus.loading));
    final result = await _downloadPdfUseCase(
      url: event.url,
      fileName: event.fileName,
    );
    if (result is Success<String>) {
      emit(state.copyWith(status: DownloadStatus.success, filePath: result.data));
    } else if (result is Failure<String>) {
      emit(state.copyWith(status: DownloadStatus.error, errorMessage: result.exception.message));
    }
  }
}
