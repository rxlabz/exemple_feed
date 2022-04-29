import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should logout', (WidgetTester tester) async {
    bool loggedOut = false;

    final app = MaterialApp(
      home: Scaffold(
        appBar: FeedAppBar(onLogout: () => loggedOut = true),
      ),
    );

    await tester.pumpWidget(app);

    await tester.tap(find.byKey(const Key('btLogout')));
    await tester.pump();

    expect(loggedOut, true);
  });
}
