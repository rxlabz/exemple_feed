import 'package:feed_app_cubit/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LABEL', (WidgetTester tester) async {
    const app = MaterialApp(home: ErrorScreen());
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    expect(find.text('Error'), findsOneWidget);
  });
}
