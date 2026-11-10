import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';
import 'l10n/app_localizations.dart';
import 'core/localization/locale_controller.dart';
import 'core/theme/jdonuts_theme.dart';
import 'features/auth/domain/usecases/user_login_use_case.dart';
import 'features/auth/presentation/providers/login_provider.dart';
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
    return ValueListenableBuilder<Locale?>(
      valueListenable: LocaleController.current,
      builder: (context, locale, _) => MaterialApp.router(
        title: "J' Donuts",
        theme: JDonutsTheme.light,
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        routerConfig: router,
      ),
    );
  }
}
