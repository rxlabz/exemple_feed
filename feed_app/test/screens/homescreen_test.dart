import 'package:feed_app/screens/feedlist_controller.dart';
import 'package:feed_app/screens/home_screen.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

void main() {
  final authController = MockAuthController();

  testWidgets('Should display message list', (WidgetTester tester) async {
    final service = MockFeedService();

    final message = Message(id: 1, name: 'Joe', message: 'Hola', date: now);
    when(() => service.loadAll())
        .thenAnswer((invocation) => Future.value([message]));

    final controller = FeedController()
      ..service = service
      ..loadAllMessages();

    final app = MultiProvider(
      providers: [
        ChangeNotifierProvider<FeedController>.value(value: controller),
        ChangeNotifierProvider<AuthController>.value(value: authController),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );
    await tester.pumpWidget(app);

    expect(find.byType(FeedAppBar), findsOneWidget);
    expect(find.byKey(const Key('btAdd')), findsOneWidget);

    await tester.pump();

    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets('Should display an error', (WidgetTester tester) async {
    final service = MockFeedService();

    when(() => service.loadAll()).thenThrow(Exception());

    final controller = FeedController()
      ..service = service
      ..loadAllMessages();

    final app = MultiProvider(
      providers: [
        ChangeNotifierProvider<FeedController>.value(value: controller),
        ChangeNotifierProvider<AuthController>.value(value: authController),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );

    await tester.pumpWidget(app);

    await tester.pump();

    expect(find.byType(ListTile), findsNothing);
    expect(find.text('Une erreur s\'est produite'), findsOneWidget);
  });

  testWidgets('Should display a spinner', (WidgetTester tester) async {
    final service = MockFeedService();

    final controller = FeedController()..service = service;

    final app = MultiProvider(
      providers: [
        ChangeNotifierProvider<FeedController>.value(
          value: controller..loadAllTask = const AsyncTask.loading(),
        ),
        ChangeNotifierProvider<AuthController >.value(value: authController),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );

    await tester.pumpWidget(app);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
    'Should open new message dialog and send a message',
    (WidgetTester tester) async {
      final service = MockFeedService();
      when(() => service.loadAll())
          .thenAnswer((invocation) => Future.value([fakeMessage]));

      when(() => service.sendMessage(fakeMessage))
          .thenAnswer((invocation) => Future.value(fakeMessage));

      when(() => authController.user).thenReturn(fakeUser);

      final controller = FeedController()..service = service;

      final app = MultiProvider(
        providers: [
          ChangeNotifierProvider<FeedController>.value(value: controller),
          ChangeNotifierProvider<AuthController>.value(value: authController),
        ],
        child: const MaterialApp(home: HomeScreen()),
      );

      await tester.pumpWidget(app);

      await tester.pumpAndSettle();

      await tester.tap(find.byType(NewMessageAsyncButton));

      await tester.pumpAndSettle();
      expect(find.byType(NewMessageDialog), findsOneWidget);

      // le clic sur envoi est désactivé si le champ est vide
      await tester.tap(find.byKey(const Key('btSend')));
      await tester.pumpAndSettle();
      expect(find.byType(NewMessageDialog), findsOneWidget);

      // on saisit un message
      await tester.enterText(find.byKey(const Key('fieldMessage')), 'Hola');
      await tester.pump();

      await tester.tap(find.byKey(const Key('btSend')));
      await tester.pumpAndSettle();

      // la popup doit être refermée
      expect(find.byType(NewMessageDialog), findsNothing);
    },
  );

  testWidgets('should logout', (tester) async {
    final service = MockFeedService();
    when(() => service.loadAll())
        .thenAnswer((invocation) => Future.value([fakeMessage]));

    when(() => authController.user).thenReturn(fakeUser);
    when(() => authController.logout()).thenReturn(null);

    final controller = FeedController()..service = service;

    final app = MultiProvider(
      providers: [
        ChangeNotifierProvider<FeedController>.value(value: controller),
        ChangeNotifierProvider<AuthController>.value(value: authController),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );

    await tester.pumpWidget(app);

    await tester.tap(find.byKey(const Key('btLogout')));

    await tester.pumpWidget(app);

    verify(() => authController.logout()).called(1);
  });
}
