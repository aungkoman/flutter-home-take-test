import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hometake/core/theme/app_theme.dart';
import 'package:hometake/features/home/presentation/widgets/home_shops_section.dart';
import 'package:hometake/features/product/domain/entities/shop_entity.dart';

void main() {
  testWidgets('shows four shops and opens the tapped shop route', (
    tester,
  ) async {
    final shops = List.generate(
      8,
      (index) => ShopEntity(
        id: index + 1,
        name: 'Shop ${index + 1}',
        description: 'Phone: 0912345678',
        address: 'Yangon',
        imageUrl: '',
        lat: 16.8,
        lng: 96.1,
      ),
    );
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: SingleChildScrollView(child: HomeShopsSection(shops: shops)),
          ),
        ),
        GoRoute(
          path: '/home/shops/:id',
          builder: (context, state) =>
              Scaffold(body: Text('Shop detail ${state.pathParameters['id']}')),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      MaterialApp.router(theme: AppTheme.light, routerConfig: router),
    );
    expect(find.byType(ListTile), findsNWidgets(4));
    final firstTitle = tester
        .widget<Text>(
          find
              .descendant(
                of: find.byType(ListTile).first,
                matching: find.byType(Text),
              )
              .first,
        )
        .data!;
    final id = firstTitle.split(' ').last;
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();
    expect(find.text('Shop detail $id'), findsOneWidget);
  });
}
