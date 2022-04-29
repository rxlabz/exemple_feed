import 'dart:convert';

import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('should login', () async {
    Future<Response> clientHandler(Request request) async {
      if (request.url.path == '/login' &&
          jsonDecode(request.body)['password'] == 'azertyui') {
        return Response(jsonEncode(fakeUser.toJson()), 200);
      }

      if (request.url.path == '/login') return Response('null', 200);

      throw Exception('invalid url ${request.url.path}');
    }

    final controller =
        AuthController(AuthService(client: MockClient(clientHandler)));

    await controller.login(mail: 'test@mail.com', password: 'azertyui');

    controller.loginTask!.maybeWhen(
      result: (user) => expect(user, fakeUser),
      orElse: () => throw Exception('Auth error'),
    );
  });
}
