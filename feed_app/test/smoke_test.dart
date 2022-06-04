import 'package:feed_app/main.dart';
import 'package:feed_app/main_provider.dart';
import 'package:feed_app/screens/detail_screen.dart';
import 'package:feed_app/screens/home_screen.dart';
import 'package:feed_app/screens/login_screen.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('SmokeTest - initial state', (tester) async {
    final authService = MockAuthService();
    when(
      () => authService.login(
        mail: any(named: 'mail'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((invocation) => Future.value(fakeUser));

    final feedService = MockFeedService();
    when(
      () => feedService.loadAll(),
    ).thenAnswer((invocation) => Future.value([fakeMessage]));

    final app = MainProvider(
      const FeedApp(),
      authService: authService,
    );

    await tester.pumpWidget(app);

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Mot de passe'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('fieldMail')), 'test@mail.com');
    await tester.pump();
    await tester.enterText(find.byKey(const Key('fieldPass')), 'azertyui');
    await tester.pump();

    await tester.tap(find.byKey(const Key('btLogin')));

    await tester.pumpAndSettle();
  });

  testWidgets(
    'Smoke test - complete',
    (WidgetTester tester) async {
      mockNetworkImagesFor() async {
        final authService = MockAuthService();

        when(
          () => authService.login(
            mail: any(named: 'mail'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((invocation) => Future.value(fakeUser));

        final feedService = MockFeedService();
        when(
          () => feedService.loadAll(),
        ).thenAnswer((invocation) => Future.value([fakeMessage, fakeMessage2]));

        when(
          () => feedService.loadMessage(any()),
        ).thenAnswer((invocation) => Future.value(fakeMessageWithReplies));

        final authController = AuthController(authService);

        final app = MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: authController),
            Provider<FeedService>.value(value: feedService)
            /*ProxyProvider<AuthController, FeedService>(
            update: (_, controller, service) =>
                FeedService(FeedClient(controller.user?.token)),
            lazy: true,
          ),*/
          ],
          child: const FeedApp(),
        );

        await tester.pumpWidget(app);

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
        expect(find.byType(ListTile), findsNWidgets(4));

        await tester.tap(find.byType(BackButton));
        await tester.pumpAndSettle();

        expect(find.byType(HomeScreen), findsOneWidget);

        await tester.tap(find.byKey(const Key('btLogout')));
        await tester.pumpAndSettle();

        expect(find.byType(LoginScreen), findsOneWidget);
      }
    },
  );
}
