import 'package:bloc_test/bloc_test.dart';
import 'package:feed_app_cubit/screens/auth_cubit.dart';
import 'package:feed_app_cubit/screens/detail_screen.dart';
import 'package:feed_app_cubit/screens/message_cubits.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: AuthCubit(authService)),
          BlocProvider.value(value: MessageCubit(feedService)),
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: AuthCubit(authService)),
          BlocProvider.value(value: MessageCubit(feedService)),
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

    final MessageCubit messageCubit = MockMessageCubit();
    when(() => messageCubit.state)
        .thenReturn(const AsyncTask<Message?>.loading());

    when(() => messageCubit.loadMessage(1)).thenAnswer((_) async {});

    final app = MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: AuthCubit(authService)),
          BlocProvider.value(value: messageCubit),
        ],
        child: const DetailsScreen(messageId: 1),
      ),
    );
    await tester.pumpWidget(app);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

class MockMessageCubit extends MockCubit<AsyncTask<Message?>>
    implements MessageCubit {}
