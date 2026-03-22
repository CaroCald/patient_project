import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService {
  final Dio _dio;

  DownloadService(this._dio);

  Future<String> downloadPdf(String url, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/$fileName.pdf';

    await _dio.download(url, filePath);

    return filePath;
  }
}
