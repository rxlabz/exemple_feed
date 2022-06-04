import 'package:feed_app_riverpod/providers.dart';
import 'package:feed_app_riverpod/screens/detail_screen.dart';
import 'package:feed_app_riverpod/screens/feedlist_controller.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  testWidgets('Should display message screen', (WidgetTester tester) async {
    final authService = MockAuthService();

    final feedService = MockFeedService();
    when(() => feedService.loadMessage(1)).thenAnswer(
      (invocation) => Future.value(fakeMessageWithReplies),
    );

    final app = MaterialApp(
      home: ProviderScope(
        overrides: [
          authServiceProvider.overrideWithValue(authService),
          feedServiceProvider.overrideWithValue(feedService),
        ],
        child: const DetailsScreen(messageId: 1),
      ),
    );
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    await tester.pumpAndSettle();

    expect(find.text('Hola'), findsOneWidget);
    expect(find.text('User0'), findsOneWidget);
  });

  testWidgets('Should display an error', (WidgetTester tester) async {
    final authService = MockAuthService();

    final feedService = MockFeedService();
    when(() => feedService.loadMessage(1)).thenThrow(Exception());

    final app = MaterialApp(
      home: ProviderScope(
        overrides: [
          authServiceProvider.overrideWithValue(authService),
          feedServiceProvider.overrideWithValue(feedService),
        ],
        child: const DetailsScreen(messageId: 1),
      ),
    );
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    await tester.pumpAndSettle();

    expect(find.text('Une erreur s\'est produite'), findsOneWidget);
  });

  testWidgets('Should display a spinner', (WidgetTester tester) async {
    final authService = MockAuthService();

    final feedService = MockFeedService();
    when(() => feedService.loadMessage(1))
        .thenAnswer((_) => Future.value(fakeMessage));

    final app = MaterialApp(
      home: ProviderScope(
        overrides: [
          authServiceProvider.overrideWithValue(authService),
          feedServiceProvider.overrideWithValue(feedService),
          feedControllerProvider.overrideWithValue(
            FeedController(service: feedService)
              ..loadDetailsTask = const AsyncTask<Message?>.loading(),
          ),
        ],
        child: const DetailsScreen(messageId: 1),
      ),
    );
    // Build our app and trigger a frame.
    await tester.pumpWidget(app);

    //await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
