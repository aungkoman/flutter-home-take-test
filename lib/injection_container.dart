import 'features/cart/domain/usecases/get_cart_items.dart';
import 'features/cart/domain/usecases/add_cart_item.dart';
import 'features/cart/domain/usecases/set_cart_item_quantity.dart';
import 'features/cart/domain/usecases/remove_cart_item.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/data/datasources/cart_local_datasource.dart';
import 'features/cart/data/datasources/selected_shop_local_datasource.dart';
import 'features/cart/data/repositories/selected_shop_repository_impl.dart';
import 'features/cart/domain/repositories/selected_shop_repository.dart';
import 'features/cart/domain/usecases/get_selected_shop_id.dart';
import 'features/cart/domain/usecases/set_selected_shop_id.dart';

import 'features/rewards/domain/usecases/get_earn_progress.dart';
import 'features/rewards/domain/usecases/get_gifts.dart';
import 'features/rewards/domain/usecases/get_earns.dart';
import 'features/rewards/domain/usecases/get_rewards.dart';
import 'features/rewards/domain/repositories/reward_repository.dart';
import 'features/rewards/data/repositories/reward_repository_impl.dart';
import 'features/rewards/data/datasources/reward_local_datasource.dart';
import 'features/product/domain/usecases/get_product_by_id.dart';
import 'features/product/domain/usecases/get_product_type_products.dart';
import 'features/product/domain/usecases/get_category_products.dart';

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
  sl.registerLazySingleton<CartLocalDatasource>(
    () => CartLocalDatasource(
      db: sl<AppDatabase>(),
      productDatasource: sl<ProductLocalDatasource>(),
      authDatasource: sl<AuthLocalDatasource>(),
    ),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDatasource: sl<CartLocalDatasource>()),
  );
  sl.registerLazySingleton<GetCartItems>(
    () => GetCartItems(repository: sl<CartRepository>()),
  );
  sl.registerLazySingleton<AddCartItem>(
    () => AddCartItem(repository: sl<CartRepository>()),
  );
  sl.registerLazySingleton<SetCartItemQuantity>(
    () => SetCartItemQuantity(repository: sl<CartRepository>()),
  );
  sl.registerLazySingleton<RemoveCartItem>(
    () => RemoveCartItem(repository: sl<CartRepository>()),
  );
  sl.registerLazySingleton<SelectedShopLocalDatasource>(
    () => SelectedShopLocalDatasource(db: sl<AppDatabase>()),
  );
  sl.registerLazySingleton<SelectedShopRepository>(
    () => SelectedShopRepositoryImpl(
      localDatasource: sl<SelectedShopLocalDatasource>(),
    ),
  );
  sl.registerLazySingleton<GetSelectedShopId>(
    () => GetSelectedShopId(repository: sl<SelectedShopRepository>()),
  );
  sl.registerLazySingleton<SetSelectedShopId>(
    () => SetSelectedShopId(repository: sl<SelectedShopRepository>()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(localDatasource: sl<ProductLocalDatasource>()),
  );
  sl.registerLazySingleton<GetProductCatalog>(
    () => GetProductCatalog(repository: sl<ProductRepository>()),
  );

  sl.registerLazySingleton<GetCategoryProducts>(
    () => GetCategoryProducts(repository: sl<ProductRepository>()),
  );

  sl.registerLazySingleton<GetProductTypeProducts>(
    () => GetProductTypeProducts(repository: sl<ProductRepository>()),
  );

  sl.registerLazySingleton<GetProductById>(
    () => GetProductById(repository: sl<ProductRepository>()),
  );

  sl.registerLazySingleton<RewardLocalDatasource>(
    () => RewardLocalDatasourceImpl(
      db: sl<AppDatabase>(),
      productLocalDatasource: sl<ProductLocalDatasource>(),
    ),
  );
  sl.registerLazySingleton<RewardRepository>(
    () => RewardRepositoryImpl(localDatasource: sl<RewardLocalDatasource>()),
  );
  sl.registerLazySingleton<GetRewards>(
    () => GetRewards(repository: sl<RewardRepository>()),
  );
  sl.registerLazySingleton<GetEarns>(
    () => GetEarns(repository: sl<RewardRepository>()),
  );
  sl.registerLazySingleton<GetGifts>(
    () => GetGifts(repository: sl<RewardRepository>()),
  );
  sl.registerLazySingleton<GetEarnProgress>(
    () => GetEarnProgress(repository: sl<RewardRepository>()),
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
