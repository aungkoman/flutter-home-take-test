import 'package:get_it/get_it.dart';

import 'features/auth/data/database/app_database.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/user_login_use_case.dart';
import 'features/auth/domain/usecases/user_otp_verify.dart';
import 'features/auth/domain/usecases/user_register.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // database
  sl.registerLazySingleton<AppDatabase>(
    AppDatabase.new,
    dispose: (AppDatabase database) => database.close(),
  );

  // remote data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(db: sl<AppDatabase>()),
  );

  // repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDatasource: sl<AuthRemoteDatasource>()),
  );

  // Use cases
  sl.registerLazySingleton<UserLoginUseCase>(
    () => UserLoginUseCase(authRepository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<UserRegister>(
    () => UserRegister(authRepository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<UserOtpVerify>(
    () => UserOtpVerify(authRepository: sl<AuthRepository>()),
  );
}
