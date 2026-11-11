import 'package:go_router/go_router.dart';
import 'package:hometake/features/auth/presentation/screens/onboarding_page.dart';
import 'package:hometake/features/auth/presentation/screens/otp_verify_page.dart';
import 'package:hometake/features/auth/presentation/screens/regiser_page.dart';

import 'features/auth/presentation/screens/phone_number_page.dart';
import 'features/home/presentation/main_shell.dart';
import 'features/home/presentation/screens/home_page.dart';
import 'features/rewards/presentation/screens/reward_page.dart';

GoRouter createAppRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardingPage(),
        routes: [
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: 'login',
            builder: (context, state) => const PhoneNumberPage(),
          ),
          GoRoute(
            path: 'otp',
            builder: (context, state) => const OtpVerifyPage(),
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
            ],
          ),

        ],
      ),
    ],
  );
}
