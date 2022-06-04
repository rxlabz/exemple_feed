import 'package:feed_app_riverpod/screens/feedlist_controller.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

void main() {
  final feedService = MockFeedService();

  test('Initial state', () {
    final controller = FeedController(service: feedService);

    expect(controller.loadAllTask, const AsyncTask<List<Message>>.result([]));
    expect(controller.loadDetailsTask, const AsyncTask<Message?>.result(null));
    expect(controller.sendMessageTask, const AsyncTask<Message?>.result(null));
  });

  test('should load all messages', () async {
    final controller = FeedController(service: feedService);

    when(() => feedService.loadAll())
        .thenAnswer((invocation) => Future.value(messages));

    await controller.loadAllMessages();

    expect(controller.loadAllTask, AsyncTask<List<Message>>.result(messages));

    controller.loadAllTask.maybeWhen(
        result: (value) => expect(value.length, 1),
        orElse: () => throw Exception());
  });

  test('should be in error state after load all messages exception', () async {
    final controller = FeedController(service: feedService);

    when(() => feedService.loadAll()).thenThrow(Exception());

    await controller.loadAllMessages();

    expect(controller.loadAllTask, const AsyncTask<List<Message>>.error());
  });

  test('should load message details', () async {
    final controller = FeedController(service: feedService);

    when(() => feedService.loadMessage(1))
        .thenAnswer((invocation) => Future.value(fakeMessage));

    await controller.loadMessage(1);

    expect(controller.loadDetailsTask, AsyncTask<Message?>.result(fakeMessage));

    controller.loadDetailsTask.maybeWhen(
        result: (value) => expect(value.id, 1),
        orElse: () => throw Exception());
  });

  test('should be in error state after load details exception', () async {
    final controller = FeedController(service: feedService);

    when(() => feedService.loadMessage(1)).thenThrow(Exception());

    await controller.loadMessage(1);

    expect(controller.loadDetailsTask, const AsyncTask<Message?>.error());
  });

  test('should send new message', () async {
    final controller = FeedController(service: feedService);

    when(() => feedService.sendMessage(fakeMessage))
        .thenAnswer((invocation) => Future.value(fakeMessage));

    await controller.sendMessage(fakeMessage);

    expect(controller.sendMessageTask, AsyncTask<Message?>.result(fakeMessage));

    controller.sendMessageTask.maybeWhen(
        result: (value) => expect(value.id, 1),
        orElse: () => throw Exception());
  });

  test('should be in error state after load details exception', () async {
    final controller = FeedController(service: feedService);

    when(() => feedService.loadMessage(1)).thenThrow(Exception());

    await controller.loadMessage(1);

    expect(controller.loadDetailsTask, const AsyncTask<Message?>.error());
  });
}
