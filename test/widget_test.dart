import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometake/main.dart' as app;

void main() {
  testWidgets('Home opens Login and Back returns to Home', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Go to Login'));
    await tester.pumpAndSettle();

    expect(find.text('Phone number'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.text('Go to Login'), findsOneWidget);
  });
}
