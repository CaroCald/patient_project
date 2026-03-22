part of 'download_bloc.dart';

enum DownloadStatus { initial, loading, success, error }

@freezed
abstract class DownloadState with _$DownloadState {
  const factory DownloadState({
    @Default(DownloadStatus.initial) DownloadStatus status,
    @Default(null) String? filePath,
    @Default(null) String? errorMessage,
  }) = _DownloadState;
}
