import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:patient_project/features/auth/presentation/screens/login_screen.dart';
import 'package:patient_project/features/home/presentation/models/home_view_model.dart';
import 'package:patient_project/features/home/presentation/screens/atencion_detail_screen.dart';
import 'package:patient_project/features/home/presentation/screens/home_screen.dart';

final GoRouter _router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/login',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(
        viewModel: state.extra as HomeViewModel,
      ),
      routes: [
        GoRoute(
          path: 'atencion',
          builder: (context, state) => AtencionDetailScreen(
            atencion: state.extra as AtencionViewModel,
          ),
        ),
      ],
    ),
  ],
);

GoRouter get goRouter => _router;
final rootNavigatorKey = GlobalKey<NavigatorState>();
