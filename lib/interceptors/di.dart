import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mentz_task/api/endPoints.dart';
import 'package:mentz_task/api/remote/auth_api.dart';
import 'package:mentz_task/features/controllers/home_provider.dart';
import 'package:mentz_task/features/repos/home_repo.dart';
import 'package:mentz_task/routing/navigation.dart';
import 'package:mentz_task/utils/appConfig.dart';

// Create an instance of GetIt to manage dependencies.
final sl = GetIt.instance;

// Initialize the dependencies.
Future<void> init() async {
  // Create a Dio client instance with base options.
  Dio client = Dio(
    BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: Endpoints.connectionTimeout),
      receiveTimeout: const Duration(milliseconds: Endpoints.receiveTimeout),
      baseUrl: Endpoints.baseUrl,
    ),
  );

  // Register the Dio instance for dependency injection.
  sl.registerLazySingleton<Dio>(() => client);

  // Register other dependencies using lazy singleton pattern.
  sl.registerLazySingleton<HttpAuth>(() => HttpAuth(client: sl()));
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => AppConfig());
  sl.registerLazySingleton(() => HomeProvider());
  sl.registerLazySingleton(() => HomeRepository());
}
