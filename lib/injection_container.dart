import 'package:get_it/get_it.dart';

import 'features/product/data/datasources/product_local_datasource.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/get_product_catalog.dart';

import 'features/auth/data/database/app_database.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';
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
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(db: sl<AppDatabase>()),
  );

  // repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authLocalDatasource: sl<AuthLocalDatasource>()),
  );

  sl.registerLazySingleton<ProductLocalDatasource>(
    () => ProductLocalDatasourceImpl(db: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(localDatasource: sl<ProductLocalDatasource>()),
  );
  sl.registerLazySingleton<GetProductCatalog>(
    () => GetProductCatalog(repository: sl<ProductRepository>()),
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
