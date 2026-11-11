import 'features/rewards/presentation/providers/rewards_provider.dart';
import 'features/cart/presentation/providers/cart_provider.dart';
import 'features/cart/presentation/providers/selected_shop_provider.dart';
import 'features/cart/domain/usecases/get_selected_shop_id.dart';
import 'features/cart/domain/usecases/set_selected_shop_id.dart';
import 'features/product/presentation/providers/product_collection_provider.dart';
import 'features/product/presentation/providers/product_detail_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/product/presentation/providers/catalog_provider.dart';
import 'features/auth/domain/usecases/user_login_use_case.dart';
import 'features/auth/presentation/providers/login_provider.dart';
import 'features/auth/domain/usecases/user_register.dart';
import 'features/auth/domain/usecases/user_otp_verify.dart';
import 'features/auth/presentation/providers/register_provider.dart';
import 'features/auth/presentation/providers/otp_verify_provider.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  final GoRouter router = createAppRouter();

  runApp(
    ProviderScope(
      overrides: [
        cartProvider.overrideWith(
          () => CartNotifier(
            getCartItems: di.sl<GetCartItems>(),
            addCartItem: di.sl<AddCartItem>(),
            setCartItemQuantity: di.sl<SetCartItemQuantity>(),
            removeCartItem: di.sl<RemoveCartItem>(),
          ),
        ),
        selectedShopProvider.overrideWith(
          () => SelectedShopNotifier(
            getSelectedShopId: di.sl<GetSelectedShopId>(),
            setSelectedShopId: di.sl<SetSelectedShopId>(),
          ),
        ),
        rewardsProvider.overrideWith2(
          (userId) => RewardsNotifier(
            getRewards: di.sl<GetRewards>(),
            getEarns: di.sl<GetEarns>(),
            getGifts: di.sl<GetGifts>(),
            getEarnProgress: di.sl<GetEarnProgress>(),
            userId: userId,
          ),
        ),
        categoryProductsProvider.overrideWith2(
          (id) => CategoryProductsNotifier(di.sl<GetCategoryProducts>(), id),
        ),
        productTypeProductsProvider.overrideWith2(
          (id) =>
              ProductTypeProductsNotifier(di.sl<GetProductTypeProducts>(), id),
        ),
        productDetailProvider.overrideWith2(
          (id) => ProductDetailNotifier(di.sl<GetProductById>(), id),
        ),
        catalogProvider.overrideWith(
          () => CatalogNotifier(di.sl<GetProductCatalog>()),
        ),
        loginProvider.overrideWith(
          () => LoginNotifier(di.sl<UserLoginUseCase>()),
        ),
        registerProvider.overrideWith(
          () => RegisterNotifier(di.sl<UserRegister>()),
        ),
        otpVerifyProvider.overrideWith(
          () => OtpVerifyNotifier(di.sl<UserOtpVerify>()),
        ),
      ],
      child: MyApp(router: router),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "J' Donuts",
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
