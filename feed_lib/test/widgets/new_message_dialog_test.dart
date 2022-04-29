import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should cancel', (WidgetTester tester) async {
    String? result;

    void onValue(String? value) {
      result = value;
    }

    final app = MaterialApp(
      home: Scaffold(body: NewMessageDialog(onValue: onValue)),
    );

    await tester.pumpWidget(app);

    expect(find.text('Nouveau message'), findsOneWidget);
    expect(find.text('Votre message'), findsOneWidget);
    expect(find.text('Annuler'), findsOneWidget);
    expect(find.text('Envoyer'), findsOneWidget);

    await tester.tap(find.text('Annuler'));
    await tester.pump();

    expect(result, null);
  });

  testWidgets('Should send', (WidgetTester tester) async {
    String? result;

    void onValue(String? value) {
      result = value;
    }

    final app = MaterialApp(
      home: Scaffold(body: NewMessageDialog(onValue: onValue)),
    );

    await tester.pumpWidget(app);

    expect(find.text('Nouveau message'), findsOneWidget);
    expect(find.text('Votre message'), findsOneWidget);
    expect(find.text('Annuler'), findsOneWidget);
    expect(find.text('Envoyer'), findsOneWidget);


    await tester.enterText(find.byKey(const Key('fieldMessage')), 'a b c');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('btSend')));
    await tester.pump();

    expect(result, 'a b c');
  });

  testWidgets('Should not send', (WidgetTester tester) async {
    String? result;

    void onValue(String? value) {
      result = value;
    }

    final app = MaterialApp(
      home: Scaffold(body: NewMessageDialog(onValue: onValue)),
    );

    await tester.pumpWidget(app);

    expect(find.text('Nouveau message'), findsOneWidget);
    expect(find.text('Votre message'), findsOneWidget);
    expect(find.text('Annuler'), findsOneWidget);
    expect(find.text('Envoyer'), findsOneWidget);

    await tester.tap(find.byKey(const Key('btSend')));
    await tester.pump();

    expect(result, null);
  });
}
