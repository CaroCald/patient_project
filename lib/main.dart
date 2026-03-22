import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patient_project/core/base/navigation/go_router_navigation/go_routes.dart';
import 'package:patient_project/core/di/service_locator.dart';
import 'package:patient_project/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:patient_project/shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844), // iPhone 14 base
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
          title: 'Patient App',
          theme: AppTheme.light,
          routerConfig: goRouter,
        ),
      ),
    );
  }
}
