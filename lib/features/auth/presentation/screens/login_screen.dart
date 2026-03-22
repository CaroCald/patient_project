import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_project/core/base/navigation/navigation_service.dart';
import 'package:patient_project/core/di/service_locator.dart';
import 'package:patient_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:patient_project/features/home/presentation/models/home_view_model.dart';
import 'package:patient_project/shared/widgets/app_button.dart';
import 'package:patient_project/shared/widgets/app_dialog.dart';
import 'package:patient_project/shared/widgets/app_scaffold.dart';
import 'package:patient_project/shared/widgets/app_text.dart';
import 'package:patient_project/shared/widgets/app_spacing.dart';
import 'package:patient_project/shared/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<AuthBloc>()..init();
  }

  @override
  Widget build(BuildContext context) => _LoginView(bloc: _bloc);
}

class _LoginView extends StatelessWidget {
  final AuthBloc bloc;

  const _LoginView({required this.bloc});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated && state.authModel != null) {
          sl<NavigationService>().go(
            '/home',
            extra: HomeViewModel.fromResponse(state.authModel!),
          );
        }
        if (state.status == AuthStatus.error) {
          AppDialog.show(
            context,
            title: 'Error al iniciar sesión',
            message: state.errorMessage ?? 'Ocurrió un error inesperado.',
            confirmLabel: 'Aceptar',
            onConfirm: () {
              bloc.clearControllers();
              Navigator.pop(context);
            },
            isDestructive: true,
          );
        }
      },
      builder: (context, state) => AppScaffold(
        showAppBar: false,
        isLoading: state.status == AuthStatus.loading,
        body: Padding(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppText.headlineLarge(
                  'Iniciar sesión',
                  textAlign: TextAlign.center,
                ),
                gapH40,
                AppTextField(
                  controller: bloc.identificationController,
                  label: 'Identificación',
                  prefixIcon: Icons.person_outline,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Ingresa tu identificación' : null,
                ),
                gapH16,
                AppPasswordField(
                  controller: bloc.passwordController,
                  label: 'Contraseña',
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Ingresa tu contraseña' : null,
                ),
                gapH32,
                AppButton(
                  label: 'Ingresar',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      bloc.add(const AuthEvent.loginRequested());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
