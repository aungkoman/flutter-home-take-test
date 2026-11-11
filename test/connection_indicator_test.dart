import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:hometake/features/home/presentation/widgets/connection_indicator.dart';

void main() {
  testWidgets('indicator switches between online and offline', (tester) async {
    final statuses = StreamController<InternetStatus>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          internetStatusProvider.overrideWith((ref) => statuses.stream),
        ],
        child: const MaterialApp(home: Scaffold(body: ConnectionIndicator())),
      ),
    );
    expect(find.text('Checking connection…'), findsOneWidget);
    statuses.add(InternetStatus.connected);
    await tester.pumpAndSettle();
    expect(find.text('Online'), findsOneWidget);
    statuses.add(InternetStatus.disconnected);
    await tester.pumpAndSettle();
    expect(find.text('Offline'), findsOneWidget);
    statuses.add(InternetStatus.connected);
    await tester.pumpAndSettle();
    expect(find.text('Online'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    unawaited(statuses.close());
  });
}
