import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:vision_erp_app/core/network/network_info.dart';
import 'package:vision_erp_app/core/platform/platform_service.dart';
import 'package:vision_erp_app/core/storage/prefs_storage_service.dart';
import 'package:vision_erp_app/core/storage/secure_storage_service.dart';
import 'package:vision_erp_app/core/storage/storage_service.dart';
import 'package:vision_erp_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:vision_erp_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vision_erp_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:vision_erp_app/features/auth/domain/usecases/login.dart';
import 'package:vision_erp_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final sl = GetIt.instance;

void init() {
  // BLoC
  sl.registerFactory(() => AuthBloc(login: sl()));

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => PlatformService());

  if (kIsWeb) {
    sl.registerLazySingleton<StorageService>(() => PrefsStorageService());
  } else {
    sl.registerLazySingleton<StorageService>(() => SecureStorageService());
  }

  // External
  sl.registerLazySingleton(() => Connectivity());
}
