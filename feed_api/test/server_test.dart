import 'dart:convert';

import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:test_process/test_process.dart';

import '../bin/server.dart';

void main() {
  final port = '8080';
  final host = 'http://0.0.0.0:$port';

  setUp(() async {
    await TestProcess.start(
      'dart',
      ['run', 'bin/server.dart'],
      environment: {'PORT': port},
    );
  });

  /*tearDown(() async {
    await TestProcess.start('kport', ['8080']);
  });*/

  test('Login', () async {
    final response = await post(Uri.parse(host + '/login'));
    expect(response.statusCode, 200);
    expect(response.body,
        '{"id":1,"name":"Jack", "mail":"jack@mail.com", "token":"Bearer eyJhbGc"}');
  });

  test('Messages', () async {
    final response = await get(Uri.parse(host + '/messages'));
    expect(response.statusCode, 200);
    expect(response.body, jsonEncode(messages, toEncodable: jsonEncoderHelper));
  });

  test('Message details', () async {
    final response = await get(Uri.parse(host + '/message/1'));
    expect(response.statusCode, 200);
    expect(
      response.body,
      jsonEncode(
        {
          'id': 1,
          'name': 'User0',
          'message':
              'In finibus sit amet tellus ac porta. Aliquam luctus luctus efficitur. Curabitur non ullamcorper velit. Nam sed vulputate mauris, in vehicula turpis. Etiam vitae ex elementum, iaculis enim id, finibus orci.',
          'date': DateTime(2022),
          'replies': replies(1),
        },
        toEncodable: jsonEncoderHelper,
      ),
    );
  });

  test('Message details', () async {
    final response = await post(
      Uri.parse(host + '/message'),
      body:
          '{"name": "Jack","mail": "jack@mail.com", "token": "Bearer eyJhbGc" }',
    );
    expect(response.statusCode, 200);
    expect(
      response.body,
      '{"name":"Jack","mail":"jack@mail.com","token":"Bearer eyJhbGc","id":100}',
    );
  });

  test('404', () async {
    final response = await get(Uri.parse(host + '/foobar'));
    expect(response.statusCode, 404);
  });
}
