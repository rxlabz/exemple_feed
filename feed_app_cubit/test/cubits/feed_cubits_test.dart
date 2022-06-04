import 'package:bloc_test/bloc_test.dart';
import 'package:feed_app_cubit/screens/message_cubits.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  late FeedService service;

  group('HomeCubit ', () {
    setUp(() {
      service = MockFeedService();
      when(() => service.loadAll())
          .thenAnswer((invocation) => Future.value([fakeMessage]));
    });

    blocTest<HomeCubit, AsyncTask<List<Message>>>(
      'should load messages',
      build: () => HomeCubit(service),
      act: (cubit) => cubit.loadAll(),
      expect: () => [
        const AsyncTask<List<Message>>.loading(),
        AsyncTask<List<Message>>.result([fakeMessage]),
      ],
    );

    blocTest<HomeCubit, AsyncTask<List<Message>>>(
      'should show error',
      build: () {
        when(() => service.loadAll()).thenThrow(Exception());
        return HomeCubit(service);
      },
      act: (cubit) => cubit.loadAll(),
      expect: () => [
        const AsyncTask<List<Message>>.loading(),
        const AsyncTask<List<Message>>.error(),
      ],
    );
  });

  group('MessageCubit ', () {
    setUp(() {
      service = MockFeedService();
      when(() => service.loadMessage(1))
          .thenAnswer((invocation) => Future.value(fakeMessageWithReplies));
    });

    blocTest<MessageCubit, AsyncTask<Message?>>(
      'should load message',
      build: () => MessageCubit(service),
      act: (cubit) => cubit.loadMessage(1),
      expect: () => [
        const AsyncTask<Message?>.loading(),
        AsyncTask<Message?>.result(fakeMessageWithReplies),
      ],
    );

    blocTest<MessageCubit, AsyncTask<Message?>>(
      'should show error',
      build: () {
        when(() => service.loadMessage(1)).thenThrow(Exception());
        return MessageCubit(service);
      },
      act: (cubit) => cubit.loadMessage(1),
      expect: () => [
        const AsyncTask<Message?>.loading(),
        const AsyncTask<Message?>.error(),
      ],
    );
  });

  group('SendMessageCubit ', () {
    setUp(() {
      service = MockFeedService();
      when(() => service.sendMessage(fakeMessage))
          .thenAnswer((invocation) => Future.value(fakeMessage));
    });

    blocTest<SendMessageCubit, AsyncTask<Message?>>(
      'should load message',
      build: () => SendMessageCubit(service),
      act: (cubit) => cubit.sendMessage(fakeMessage),
      expect: () => [
        const AsyncTask<Message?>.loading(),
        AsyncTask<Message?>.result(fakeMessage),
      ],
    );

    blocTest<SendMessageCubit, AsyncTask<Message?>>(
      'should show error',
      build: () {
        when(() => service.sendMessage(fakeMessage)).thenThrow(Exception());
        return SendMessageCubit(service);
      },
      act: (cubit) => cubit.sendMessage(fakeMessage),
      expect: () => [
        const AsyncTask<Message?>.loading(),
        const AsyncTask<Message?>.error(),
      ],
    );
  });
}
