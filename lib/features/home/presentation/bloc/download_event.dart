part of 'download_bloc.dart';

@freezed
abstract class DownloadEvent with _$DownloadEvent {
  const factory DownloadEvent.downloadRequested({
    required String url,
    required String fileName,
  }) = _DownloadRequested;
}
