import 'package:feed_app/main.dart' as app;
import 'package:feed_app/screens/detail_screen.dart';
import 'package:feed_app/screens/home_screen.dart';
import 'package:feed_app/screens/login_screen.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('global test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Mot de passe'), findsOneWidget);

      await tester.enterText(
          find.byKey(const Key('fieldMail')), 'test@mail.com');
      await tester.pump();
      await tester.enterText(find.byKey(const Key('fieldPass')), 'azertyui');
      await tester.pump();

      await tester.tap(find.byKey(const Key('btLogin')));

      await tester.pumpAndSettle();

      expect(find.text('Email'), findsNothing);
      expect(find.text('Mot de passe'), findsNothing);

      expect(find.byType(HomeScreen), findsOneWidget);

      final btNewMessage = find.byKey(const Key('btAdd'));

      await tester.tap(btNewMessage);
      await tester.pumpAndSettle();

      expect(find.byType(NewMessageDialog), findsOneWidget);

      await tester.tap(find.byKey(const Key('btCancel')));
      await tester.pumpAndSettle();
      expect(find.byType(NewMessageDialog), findsNothing);

      await tester.tap(find.byKey(const Key('tile0')));

      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(DetailsScreen), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(MessageCard), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(9));

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);

      await tester.tap(find.byKey(const Key('btLogout')));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
