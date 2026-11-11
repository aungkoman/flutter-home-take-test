import 'package:flutter/material.dart';

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
import 'features/product/domain/entities/category_entity.dart';
import 'features/product/domain/entities/product_type_entity.dart';
import 'features/product/presentation/widgets/product_hero_tags.dart';
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
            redirect: (context, state) =>
                '/home/catalog${state.uri.hasQuery ? '?${state.uri.query}' : ''}',
          ),
          GoRoute(
            path: 'categories/:id',
            redirect: (context, state) =>
                '/home/categories/${state.pathParameters['id']}',
          ),
          GoRoute(
            path: 'product-types/:id',
            redirect: (context, state) =>
                '/home/product-types/${state.pathParameters['id']}',
          ),
          GoRoute(
            path: 'products/:id',
            redirect: (context, state) =>
                '/home/products/${state.pathParameters['id']}',
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
                    routes: [
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
                        pageBuilder: (context, state) {
                          final CategoryEntity? preview =
                              state.extra is CategoryEntity
                              ? state.extra as CategoryEntity
                              : null;
                          return _heroTransitionPage(
                            state,
                            CategoryDetailPage(
                              id: state.pathParameters['id']!,
                              name: preview?.name,
                              imageUrl: preview?.imageUrl,
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'product-types/:id',
                        pageBuilder: (context, state) {
                          final ProductTypeEntity? preview =
                              state.extra is ProductTypeEntity
                              ? state.extra as ProductTypeEntity
                              : null;
                          return _heroTransitionPage(
                            state,
                            ProductTypeDetailPage(
                              id: state.pathParameters['id']!,
                              name: preview?.name,
                              imageUrl: preview?.imageUrl,
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'products/:id',
                        pageBuilder: (context, state) {
                          final ProductHeroRouteData? preview =
                              state.extra is ProductHeroRouteData
                              ? state.extra as ProductHeroRouteData
                              : null;
                          return _heroTransitionPage(
                            state,
                            ProductDetailPage(
                              id: state.pathParameters['id']!,
                              heroData: preview,
                            ),
                          );
                        },
                      ),
                    ],
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

CustomTransitionPage<void> _heroTransitionPage(
  GoRouterState state,
  Widget child,
) => CustomTransitionPage<void>(
  key: state.pageKey,
  child: child,
  transitionDuration: const Duration(milliseconds: 900),
  reverseTransitionDuration: const Duration(milliseconds: 700),
  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
      FadeTransition(opacity: animation, child: child),
);
