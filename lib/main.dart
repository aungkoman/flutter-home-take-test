import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';
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
      title: "J' Donuts",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}
