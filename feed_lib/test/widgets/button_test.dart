import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should logout', (WidgetTester tester) async {
    bool loggedOut = false;

    final app = MaterialApp(
      home: Scaffold(
        body: Center(child: LogoutButton(onLogout: () => loggedOut = true)),
      ),
    );

    await tester.pumpWidget(app);

    await tester.tap(find.byIcon(Icons.logout));
    await tester.pump();

    expect(loggedOut, true);
  });
}
