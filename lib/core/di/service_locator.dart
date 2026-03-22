import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:patient_project/core/base/navigation/go_router_navigation/go_router_navigation_service.dart';
import 'package:patient_project/core/base/navigation/go_router_navigation/go_routes.dart';
import 'package:patient_project/core/base/navigation/navigation_service.dart';
import 'package:patient_project/core/base/network/network.dart';
import 'package:patient_project/shared/storage/secure_storage/secure_storage_service.dart';
import 'package:patient_project/shared/storage/storage_service.dart';
import 'package:patient_project/shared/services/connectivity_service.dart';
import 'package:patient_project/shared/services/download_service.dart';
import 'package:patient_project/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:patient_project/features/home/domain/use_cases/download_pdf_use_case.dart';
import 'package:patient_project/features/home/presentation/bloc/download_bloc.dart';
import 'package:patient_project/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:patient_project/features/auth/domain/repositories/auth_repository.dart';
import 'package:patient_project/features/auth/domain/use_cases/login_use_case.dart';
import 'package:patient_project/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:patient_project/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

const bool useMock = true;

Future<void> setupServiceLocator() async {
  // Navigation
  sl.registerLazySingleton<NavigationService>(
    () => GoRouterNavigationService(goRouter),
  );

  // Storage
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sl.registerLazySingleton<StorageService>(
    () => SecureStorageService(sl<FlutterSecureStorage>()),
  );

  // Connectivity
  sl.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

  // Download service
  sl.registerLazySingleton<DownloadService>(() => DownloadService(Dio()));
  sl.registerLazySingleton<DownloadPdfUseCase>(
    () => DownloadPdfUseCase(sl<DownloadService>()),
  );
  sl.registerFactory<DownloadBloc>(
    () => DownloadBloc(sl<DownloadPdfUseCase>()),
  );

  // Auth interceptor (lee el token desde StorageService en cada request)
  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(sl<StorageService>()),
  );

  if (!useMock) {
    sl.registerLazySingleton<Dio>(() {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://your-api-base-url.com',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        ),
      );
      dio.interceptors.add(sl<AuthInterceptor>());
      return dio;
    });

    sl.registerLazySingleton<HttpClientService>(
      () => DioHttpClient(sl<Dio>()),
    );
  }

  // Auth
  sl.registerLazySingleton<AuthRepository>(
    () => useMock
        ? AuthRepositoryMock()
        : AuthRepositoryImpl(sl<HttpClientService>()),
  );
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>(), sl<StorageService>(), sl<ConnectivityService>()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<AuthRepository>(), sl<StorageService>()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      sl<LoginUseCase>(),
      sl<LogoutUseCase>(),
    ),
  );
}
