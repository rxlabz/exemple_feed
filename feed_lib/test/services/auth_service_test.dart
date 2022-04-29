import 'dart:convert';

import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/fake_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  Future<Response> clientHandler(Request request) async {
    if (request.url.path == '/login' &&
        jsonDecode(request.body)['password'] == 'azertyui') {
      return Response(jsonEncode(fakeUser.toJson()), 200);
    }

    if (request.url.path == '/login') return Response('null', 200);

    throw Exception('invalid url ${request.url.path}');
  }

  test('should return logged user', () async {
    final service = AuthService(client:MockClient(clientHandler));

    final response =
        await service.login(mail: 'test@mail.com', password: 'azertyui');

    expect(response, fakeUser);
  });

  test('should return null', () async {
    final service = AuthService(client:MockClient(clientHandler));

    final response =
        await service.login(mail: 'test@mail.com', password: 'aaa');

    expect(response, null);
  });
}
