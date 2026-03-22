import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
abstract class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    required String token,
    required String paciente,
    required List<AtencionModel> atenciones,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}

@freezed
abstract class AtencionModel with _$AtencionModel {
  const factory AtencionModel({
    required String id,
    required String fecha,
    required String servicio,
    required String orden,
    required String estado,
    String? pdfUrl,
  }) = _AtencionModel;

  factory AtencionModel.fromJson(Map<String, dynamic> json) =>
      _$AtencionModelFromJson(json);
}
