import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_project/core/base/navigation/navigation_service.dart';
import 'package:patient_project/core/di/service_locator.dart';
import 'package:patient_project/features/home/presentation/bloc/download_bloc.dart';
import 'package:patient_project/features/home/presentation/models/home_view_model.dart';
import 'package:patient_project/shared/theme/app_colors.dart';
import 'package:patient_project/shared/widgets/app_button.dart';
import 'package:patient_project/shared/widgets/app_dialog.dart';
import 'package:patient_project/shared/widgets/app_scaffold.dart';
import 'package:patient_project/shared/widgets/app_spacing.dart';
import 'package:patient_project/shared/widgets/app_text.dart';

class AtencionDetailScreen extends StatelessWidget {
  final AtencionViewModel atencion;

  const AtencionDetailScreen({super.key, required this.atencion});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DownloadBloc>(),
      child: _AtencionDetailView(atencion: atencion),
    );
  }
}

class _AtencionDetailView extends StatelessWidget {
  final AtencionViewModel atencion;

  const _AtencionDetailView({required this.atencion});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: atencion.servicio,
      onBack: () => sl<NavigationService>().pop(),
      body: BlocConsumer<DownloadBloc, DownloadState>(
        listener: (context, state) {
          if (state.status == DownloadStatus.success) {
            AppDialog.show(
              context,
              title: 'Descarga completada',
              message: 'El PDF fue guardado correctamente en tu dispositivo.',
              confirmLabel: 'Aceptar',
              onConfirm: () {},
            );
          }
          if (state.status == DownloadStatus.error) {
            AppDialog.show(
              context,
              title: 'Error al descargar',
              message: state.errorMessage ?? 'Ocurrió un error inesperado.',
              confirmLabel: 'Aceptar',
              onConfirm: () {},
              isDestructive: true,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailCard(atencion: atencion),
                gapH24,
                _EstadoResultado(atencion: atencion),
                if (atencion.hasResult) ...[
                  gapH32,
                  AppButton(
                    label: 'Descargar resultado',
                    isLoading: state.status == DownloadStatus.loading,
                    onPressed: () => context.read<DownloadBloc>().add(
                          DownloadEvent.downloadRequested(
                            url: atencion.pdfUrl!,
                            fileName: atencion.orden,
                          ),
                        ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final AtencionViewModel atencion;

  const _DetailCard({required this.atencion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailRow(label: 'Servicio', value: atencion.servicio),
          gapH16,
          _DetailRow(label: 'Número de orden', value: atencion.orden),
          gapH16,
          _DetailRow(label: 'Fecha', value: atencion.fecha),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.bodyMedium(label),
        gapH4,
        AppText.bodyLarge(value, fontWeight: FontWeight.w600),
      ],
    );
  }
}

class _EstadoResultado extends StatelessWidget {
  final AtencionViewModel atencion;

  const _EstadoResultado({required this.atencion});

  @override
  Widget build(BuildContext context) {
    final color = atencion.isReady ? Colors.green : Colors.orange;
    final icon = atencion.isReady ? Icons.check_circle_outline : Icons.access_time;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32.r),
          gapW16,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText.bodyMedium('Estado del resultado'),
              gapH4,
              AppText.titleLarge(atencion.estadoLabel, color: color),
            ],
          ),
        ],
      ),
    );
  }
}
