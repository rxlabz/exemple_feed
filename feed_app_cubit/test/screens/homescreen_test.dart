import 'package:bloc_test/bloc_test.dart';
import 'package:feed_app_cubit/screens/auth_cubit.dart';
import 'package:feed_app_cubit/screens/home_screen.dart';
import 'package:feed_app_cubit/screens/message_cubits.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthCubit extends MockCubit<AsyncTask<User?>> implements AuthCubit {}

class MockHomeCubit extends MockCubit<AsyncTask<List<Message>>>
    implements HomeCubit {}

void main() {
  final authCubit = MockAuthCubit();

  testWidgets('Should display message list', (WidgetTester tester) async {
    final service = MockFeedService();

    final message = Message(id: 1, name: 'Joe', message: 'Hola', date: now);
    when(() => service.loadAll())
        .thenAnswer((invocation) => Future.value([message]));

    final homeCubit = HomeCubit(service)..loadAll();
    final sendMessageCubit = SendMessageCubit(service);

    final app = MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>.value(value: homeCubit),
        BlocProvider<SendMessageCubit>.value(value: sendMessageCubit),
        BlocProvider<AuthCubit>.value(value: authCubit),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );
    await tester.pumpWidget(app);

    expect(find.byType(FeedAppBar), findsOneWidget);
    expect(find.byKey(const Key('btAdd')), findsOneWidget);

    await tester.pump();

    expect(find.byType(MessageTile), findsOneWidget);
  });

  testWidgets('Should display an error', (WidgetTester tester) async {
    final service = MockFeedService();

    when(() => service.loadAll()).thenThrow(Exception());

    final homeCubit = HomeCubit(service)..loadAll();
    final sendMessageCubit = SendMessageCubit(service);

    final app = MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: authCubit),
        BlocProvider<HomeCubit>.value(value: homeCubit),
        BlocProvider<SendMessageCubit>.value(value: sendMessageCubit),
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

    final homeCubit = MockHomeCubit();
    when(() => homeCubit.state).thenReturn(const AsyncTask.loading());

    final sendMessageCubit = SendMessageCubit(service);

    final app = MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: authCubit),
        BlocProvider<HomeCubit>.value(value: homeCubit),
        BlocProvider<SendMessageCubit>.value(value: sendMessageCubit),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );

    await tester.pumpWidget(app);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
    'Should open new message dialog and send a message',
    (WidgetTester tester) async {
      when(() => authCubit.state).thenReturn(const AsyncTask.result(fakeUser));

      final service = MockFeedService();
      when(() => service.loadAll())
          .thenAnswer((invocation) => Future.value([fakeMessage]));

      when(() => service.sendMessage(fakeMessage))
          .thenAnswer((invocation) => Future.value(fakeMessage));

      //when(() => authCubit.user).thenReturn(fakeUser);

      final homeCubit = HomeCubit(service)..loadAll();
      final sendMessageCubit = SendMessageCubit(service);

      final app = MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>.value(value: authCubit),
          BlocProvider<HomeCubit>.value(value: homeCubit),
          BlocProvider<SendMessageCubit>.value(value: sendMessageCubit),
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

    //when(() => authController.user).thenReturn(fakeUser);
    when(() => authCubit.logout()).thenReturn(null);

    final homeCubit = HomeCubit(service);
    final sendMessageCubit = SendMessageCubit(service);

    final app = MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: authCubit),
        BlocProvider<HomeCubit>.value(value: homeCubit),
        BlocProvider<SendMessageCubit>.value(value: sendMessageCubit),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );

    await tester.pumpWidget(app);

    await tester.tap(find.byKey(const Key('btLogout')));

    await tester.pumpWidget(app);

    verify(() => authCubit.logout()).called(1);
  });
}
