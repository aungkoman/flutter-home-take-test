import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/core/theme/app_theme.dart';
import 'package:hometake/features/auth/presentation/screens/onboarding_page.dart';
import 'package:hometake/features/home/presentation/widgets/tab_ui.dart';
import 'package:hometake/features/order/presentation/screens/order_page.dart';
import 'package:hometake/features/settings/presentation/screens/settings_page.dart';
import 'package:hometake/features/wallet/presentation/screens/wallet_page.dart';

void main() {
  group('AppTheme & AppColors', () {
    test(
      'provides brand color scheme, text theme, and AppColors extension',
      () {
        final ThemeData theme = AppTheme.light;

        expect(theme.useMaterial3, isTrue);
        expect(theme.colorScheme.primary, const Color(0xFF60C1DE));
        expect(theme.colorScheme.secondary, const Color(0xFFDC629F));
        expect(theme.scaffoldBackgroundColor, AppColors.light.pageBackground);
        expect(theme.extension<AppColors>(), AppColors.light);
        expect(theme.textTheme.displaySmall?.fontSize, 32);
        expect(theme.textTheme.titleSmall?.height, 1.25);
      },
    );

    test('AppColors.copyWith and lerp update and interpolate tokens', () {
      final AppColors modified = AppColors.light.copyWith(
        pageBackground: Colors.black,
        bannerPalette: const [Colors.black, Colors.white, Colors.grey],
      );

      expect(modified.pageBackground, Colors.black);
      expect(modified.headerCyan, AppColors.light.headerCyan);

      final AppColors mid = AppColors.light.lerp(modified, 0.5);
      expect(
        mid.pageBackground,
        Color.lerp(AppColors.light.pageBackground, Colors.black, 0.5),
      );
      expect(
        mid.bannerPalette.first,
        Color.lerp(AppColors.light.bannerPalette.first, Colors.black, 0.5),
      );
    });

    testWidgets('BuildContext theme accessors resolve extension and fallback', (
      tester,
    ) async {
      late AppColors themedColors;
      late AppColors fallbackColors;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Builder(
            builder: (context) {
              themedColors = context.appColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(themedColors, AppColors.light);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              fallbackColors = context.appColors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      expect(fallbackColors, AppColors.light);
    });
  });

  group('Themed screens & widgets', () {
    testWidgets('Onboarding, Order, Wallet, Settings, and TabPills use theme', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(theme: AppTheme.light, home: const OnboardingPage()),
      );
      final Scaffold onboardingScaffold = tester.widget(find.byType(Scaffold));
      expect(
        onboardingScaffold.backgroundColor,
        AppColors.light.blushBackground,
      );

      await tester.pumpWidget(
        MaterialApp(theme: AppTheme.light, home: const OrderPage()),
      );
      final Scaffold orderScaffold = tester.widget(find.byType(Scaffold));
      expect(orderScaffold.backgroundColor, AppColors.light.pageBackground);

      await tester.pumpWidget(
        MaterialApp(theme: AppTheme.light, home: const WalletPage()),
      );
      expect(find.text('Wallet Balance (Ks)'), findsOneWidget);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(theme: AppTheme.light, home: const SettingsPage()),
        ),
      );
      expect(find.text('Your account'), findsOneWidget);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: TabPills(
              labels: const ['First', 'Second'],
              selected: 0,
              onSelected: (_) {},
            ),
          ),
        ),
      );
      final ChoiceChip firstChip = tester.widget(find.byType(ChoiceChip).first);
      expect(firstChip.selectedColor, AppTheme.light.colorScheme.primary);
      expect(firstChip.backgroundColor, AppColors.light.pageBackground);
    });
  });
}
