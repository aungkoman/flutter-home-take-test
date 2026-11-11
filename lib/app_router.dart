import 'features/settings/presentation/screens/settings_page.dart';
import 'features/wallet/presentation/screens/wallet_page.dart';
import 'features/order/presentation/screens/order_page.dart';

import 'package:go_router/go_router.dart';
import 'package:hometake/features/auth/presentation/screens/welcome_page.dart';

import 'features/product/presentation/screens/catalog_page.dart';

import 'package:hometake/features/auth/presentation/screens/onboarding_page.dart';
import 'package:hometake/features/auth/presentation/screens/otp_verify_page.dart';
import 'package:hometake/features/auth/presentation/screens/regiser_page.dart';

import 'features/auth/presentation/screens/phone_number_page.dart';
import 'features/home/presentation/main_shell.dart';
import 'features/home/presentation/screens/home_page.dart';
import 'features/product/presentation/screens/category_detail_page.dart';
import 'features/product/presentation/screens/product_detail_page.dart';
import 'features/product/presentation/screens/product_type_detail_page.dart';
import 'features/rewards/presentation/screens/reward_page.dart';

GoRouter createAppRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardingPage(),
        routes: [
          // its' all about entering phone number
          GoRoute(
            path: 'login',
            builder: (context, state) => const PhoneNumberPage(),
          ),
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: 'otp',
            builder: (context, state) => const OtpVerifyPage(),
          ),
          GoRoute(
            path: 'welcome',
            builder: (context, state) => const WelcomePage(),
          ),

          GoRoute(
            path: 'catalog',
            builder: (context, state) => CatalogPage(
              categoryId: int.tryParse(
                state.uri.queryParameters['categoryId'] ?? '',
              ),
              productTypeId: int.tryParse(
                state.uri.queryParameters['productTypeId'] ?? '',
              ),
            ),
          ),
          GoRoute(
            path: 'categories/:id',
            builder: (context, state) =>
                CategoryDetailPage(id: state.pathParameters['id']!),
          ),
          GoRoute(
            path: 'product-types/:id',
            builder: (context, state) =>
                ProductTypeDetailPage(id: state.pathParameters['id']!),
          ),
          GoRoute(
            path: 'products/:id',
            builder: (context, state) =>
                ProductDetailPage(id: state.pathParameters['id']!),
          ),

          // Bottom-nav shell
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) =>
                MainShell(navigationShell: navigationShell),
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/home',
                    builder: (context, state) => const HomePage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/reward',
                    builder: (context, state) => const RewardPage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/order',
                    builder: (context, state) => const OrderPage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/wallet',
                    builder: (context, state) => const WalletPage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/settings',
                    builder: (context, state) => const SettingsPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
