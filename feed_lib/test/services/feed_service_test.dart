import 'dart:convert';

import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/fake_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  Future<Response> clientHandler(Request request) async {
    if (request.url.path == '/messages') {
      return Response(
        jsonEncode([fakeMessage.toJson(), fakeMessage2.toJson()]),
        200,
      );
    }

    if (request.url.path == '/message/1') {
      return Response(jsonEncode(fakeMessageWithReplies), 200);
    }

    if (request.url.path == '/message') {
      return Response(jsonEncode(fakeMessage), 200);
    }

    throw Exception('invalid url ${request.url.path}');
  }

  test('should return a list of messages', () async {
    final service = FeedService(MockClient(clientHandler));

    final response = await service.loadAll();

    expect(response.first, fakeMessage);
    expect(response.length, 2);
  });

  test('should return the message details', () async {
    final service = FeedService(MockClient(clientHandler));

    final response = await service.loadMessage(1);

    expect(response.replies?.length, 4);
  });

  test('should send a new message', () async {
    final service = FeedService(MockClient(clientHandler));

    final response = await service.sendMessage(fakeMessage);

    expect(response, fakeMessage);
  });
}
