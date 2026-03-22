import 'package:patient_project/features/auth/data/models/auth/response/auth_response_model.dart';

class HomeViewModel {
  final String paciente;
  final List<AtencionViewModel> atenciones;

  const HomeViewModel({
    required this.paciente,
    required this.atenciones,
  });

  factory HomeViewModel.fromResponse(AuthResponseModel response) {
    return HomeViewModel(
      paciente: response.paciente,
      atenciones: response.atenciones
          .map(AtencionViewModel.fromModel)
          .toList(),
    );
  }
}

class AtencionViewModel {
  final String id;
  final String fecha;
  final String servicio;
  final String orden;
  final String estado;
  final String? pdfUrl;

  const AtencionViewModel({
    required this.id,
    required this.fecha,
    required this.servicio,
    required this.orden,
    required this.estado,
    this.pdfUrl,
  });

  bool get hasResult => pdfUrl != null;
  bool get isReady => estado.toLowerCase() == 'listo';
  String get estadoLabel => isReady ? 'Listo para descarga' : 'En proceso';

  factory AtencionViewModel.fromModel(AtencionModel model) {
    return AtencionViewModel(
      id: model.id,
      fecha: model.fecha,
      servicio: model.servicio,
      orden: model.orden,
      estado: model.estado,
      pdfUrl: model.pdfUrl,
    );
  }
}
