import 'package:feed_app/screens/login_screen.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

void main() {
  final mailField = find.byKey(const Key('fieldMail'));

  var btLogin = find.byKey(const Key('btLogin'));

  final passField = find.byKey(const Key('fieldPass'));

  testWidgets('Initial State', (WidgetTester tester) async {
    final mockAuthController = MockAuthController();

    final app = ChangeNotifierProvider<AuthController>.value(
      value: mockAuthController,
      child: MaterialApp(home: LoginScreen()),
    );
    await tester.pumpWidget(app);

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Mot de passe'), findsOneWidget);
    expect(find.text('Entrer'), findsOneWidget);
    expect(find.text("Une erreur s'est produite"), findsNothing);
  });

  testWidgets('Login form validation', (WidgetTester tester) async {
    final mockAuthController = MockAuthController();
    when(
      () => mockAuthController.login(
        mail: any(named: 'mail'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((invocation) => Future.value(null));

    final app = ChangeNotifierProvider<AuthController>.value(
      value: mockAuthController,
      child: MaterialApp(home: LoginScreen()),
    );
    await tester.pumpWidget(app);

    await tester.enterText(mailField, 'toto');

    await tester.pump();

    await tester.tap(btLogin);

    await tester.pumpAndSettle();

    expect(find.text('Email invalide'), findsOneWidget);

    await tester.enterText(mailField, 'test@mail.com');

    await tester.tap(btLogin);

    await tester.pumpAndSettle();

    expect(find.text('Email invalide'), findsNothing);

    expect(find.text('8 caractères minimum'), findsOneWidget);

    await tester.enterText(passField, 'azertyuiaz');
    await tester.pump();

    await tester.tap(btLogin);
    await tester.pumpAndSettle();

    expect(find.text('8 caractères minimum'), findsNothing);
  });

  testWidgets('show pending call', (tester) async {
    final mockAuthController = MockAuthController();
    when(() => mockAuthController.loginTask)
        .thenReturn(const AsyncTask.loading());

    final app = ChangeNotifierProvider<AuthController>.value(
      value: mockAuthController,
      child: MaterialApp(home: LoginScreen()),
    );

    await tester.pumpWidget(app);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('show authentication error', (tester) async {
    final authService = MockAuthService();
    final controller = AuthController(authService);

    when(() => authService.login(
          mail: any(named: 'mail'),
          password: any(named: 'password'),
        )).thenAnswer((_) => Future.value(null));

    final app = ChangeNotifierProvider<AuthController>.value(
      value: controller,
      child: MaterialApp(home: LoginScreen()),
    );

    await tester.pumpWidget(app);

    await tester.enterText(mailField, 'test@mail.com');

    await tester.enterText(passField, 'azertyui');

    await tester.tap(btLogin);
    await tester.pump();

    await tester.pumpAndSettle();

    expect(find.text("Erreur d'identification"), findsOneWidget);
  });

  testWidgets('show API error', (tester) async {
    final mockAuthController = MockAuthController();
    when(() => mockAuthController.loginTask)
        .thenReturn(const AsyncTask.error());

    final app = ChangeNotifierProvider<AuthController>.value(
      value: mockAuthController,
      child: MaterialApp(home: LoginScreen()),
    );

    await tester.pumpWidget(app);

    expect(find.text("Une erreur s'est produite"), findsOneWidget);
  });
}
