import 'package:patient_project/core/error/error_handler.dart';
import 'package:patient_project/core/result/data_result.dart';
import 'package:patient_project/shared/services/download_service.dart';

class DownloadPdfUseCase {
  final DownloadService _downloadService;

  DownloadPdfUseCase(this._downloadService);

  Future<DataResult<String>> call({
    required String url,
    required String fileName,
  }) async {
    try {
      final path = await _downloadService.downloadPdf(url, fileName);
      return Success(path);
    } catch (e) {
      return Failure(ErrorHandler.handle(e));
    }
  }
}
