import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_project/core/base/navigation/navigation_service.dart';
import 'package:patient_project/core/di/service_locator.dart';
import 'package:patient_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:patient_project/features/home/presentation/models/home_view_model.dart';
import 'package:patient_project/shared/theme/app_colors.dart';
import 'package:patient_project/shared/widgets/app_dialog.dart';
import 'package:patient_project/shared/widgets/app_scaffold.dart';
import 'package:patient_project/shared/widgets/app_spacing.dart';
import 'package:patient_project/shared/widgets/app_text.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          sl<NavigationService>().go('/login');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) => AppScaffold(
          isLoading: state.status == AuthStatus.loading,
          title: 'Hola, ${viewModel.paciente}',
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: AppColors.surface),
              onPressed: () => AppDialog.show(
                context,
                title: 'Cerrar sesión',
                message: '¿Estás seguro que deseas cerrar sesión?',
                confirmLabel: 'Salir',
                cancelLabel: 'Cancelar',
                isDestructive: true,
                onConfirm: () =>
                    context.read<AuthBloc>().add(const AuthEvent.logoutRequested()),
              ),
            ),
          ],
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText.headlineMedium('Atenciones Médicas'),
                gapH16,
                Expanded(
                  child: ListView.separated(
                    itemCount: viewModel.atenciones.length,
                    separatorBuilder: (_, _) => gapH12,
                    itemBuilder: (context, index) {
                      final atencion = viewModel.atenciones[index];
                      return _AtencionCard(
                        atencion: atencion,
                        onTap: () => sl<NavigationService>().push('/home/atencion', extra: atencion),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AtencionCard extends StatelessWidget {
  final AtencionViewModel atencion;
  final VoidCallback onTap;

  const _AtencionCard({required this.atencion, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.titleLarge(atencion.servicio),
                  _EstadoBadge(isReady: atencion.isReady, label: atencion.estado),
                ],
              ),
              gapH8,
              AppText.bodyMedium('Orden: ${atencion.orden}'),
              gapH4,
              AppText.bodyMedium('Fecha: ${atencion.fecha}'),
            ],
          ),
        ),
      ),
    );
  }
}

class _EstadoBadge extends StatelessWidget {
  final bool isReady;
  final String label;

  const _EstadoBadge({required this.isReady, required this.label});

  Color get _color => isReady ? Colors.green : Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: AppText.caption(
        label,
        color: _color,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
