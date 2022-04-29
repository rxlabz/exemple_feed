import 'dart:io';

import 'package:feed_lib/feed_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

const token = 'A1B2CDEF';

void main() {
  Future<Response> clientHandler(Request request) async =>
      Response(request.headers['Authorization'] ?? '', 200);

  test(
    'should add authorization header',
    () async {
      final client = FeedClient(token, client: MockClient(clientHandler));

      final response = await client.get(Uri.parse('http://localhost'));

      expect(response.body, token);
    },
  );

  test(
    'should throws',
    () async {
      final client = FeedClient(token);

      expect(
        () async => await client.get(Uri.parse('http://localhost:1234')),
        throwsA(const TypeMatcher<SocketException>()),
      );
    },
  );
}
