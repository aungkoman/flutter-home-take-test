import 'package:go_router/go_router.dart';
import 'package:hometake/features/auth/presentation/screens/onboarding_page.dart';
import 'package:hometake/features/auth/presentation/screens/otp_verify_page.dart';
import 'package:hometake/features/auth/presentation/screens/regiser_page.dart';

import 'features/auth/presentation/screens/login_page.dart';
import 'features/home/presentation/screens/home_page.dart';

GoRouter createAppRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardingPage(),
        routes: [
          GoRoute(
            path: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            path: 'login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: 'otp',
            builder: (context, state) => const OtpVerifyPage(),
          ),
        ],
      ),
    ],
  );
}
