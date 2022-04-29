import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Should display message info',
    (WidgetTester tester) async {
      bool tapped = false;

      final app = MaterialApp(
        home: Scaffold(
          body: MessageTile(
            message: fakeMessage,
            index: 0,
            onTap: () => tapped = true,
          ),
        ),
      );
      // Build our app and trigger a frame.
      await tester.pumpWidget(app);

      expect(find.text('Joe'), findsOneWidget);
      expect(find.text('Hola'), findsOneWidget);
      expect(find.byKey(const Key('tile0')), findsOneWidget);

      await tester.tap(find.byKey(const Key('tile0')));
      await tester.pump();

      expect(tapped, true);
    },
  );
}
