import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';

final List<Map<String, dynamic>> messages = List.generate(
  100,
  (index) => {
    'id': index + 1,
    'name': 'User$index',
    'message':
        'In finibus sit amet tellus ac porta. Aliquam luctus luctus efficitur. Curabitur non ullamcorper velit. Nam sed vulputate mauris, in vehicula turpis. Etiam vitae ex elementum, iaculis enim id, finibus orci.',
    'date': DateTime(2022).add(Duration(days: index))
  },
);
List<Map<String, dynamic>> replies(int messageId) => List.generate(
      10,
      (index) => {
        'id': index + 1,
        'messageId': messageId,
        'name': 'User$index',
        'message':
            'In finibus sit amet tellus ac porta. Aliquam luctus luctus efficitur. Curabitur non ullamcorper velit. Nam sed vulputate mauris, in vehicula turpis. Etiam vitae ex elementum, iaculis enim id, finibus orci.',
        'date': DateTime(2022).add(Duration(days: index))
      },
    );

// Configure routes.
final _router = Router()
  ..post('/login', _loginHandler)
  ..get('/messages', _listHandler)
  ..get('/message/<messageId>', _detailsHandler)
  ..post('/message', _newMessageHandler);

Future<Response> _loginHandler(Request request) async => Future.delayed(
      const Duration(seconds: 1),
      () => Response.ok(
        '{"id":1,"name":"Jack", "mail":"jack@mail.com", "token":"Bearer eyJhbGc"}',
      ),
    );

Future<Response> _listHandler(Request request) async {
  if (request.headers['authorization'] != "Bearer eyJhbGc") {
    return Response.forbidden('{"error":"Unauthenticated"}');
  }
  return Future.delayed(
    const Duration(seconds: 1),
    () => Response.ok(jsonEncode(messages, toEncodable: jsonEncoderHelper)),
  );
}

Future<Response> _newMessageHandler(Request request) async {
  if (request.headers['authorization'] != "Bearer eyJhbGc") {
    return Response.forbidden('{"error":"Unauthenticated"}');
  }
  final newMessage = jsonDecode(await request.readAsString());
  newMessage['id'] = messages.length;
  messages.insert(0, newMessage);
  return Future.delayed(
    const Duration(seconds: 1),
    () => Response.ok(jsonEncode(newMessage)),
  );
}

Response _detailsHandler(Request request) {
  if (request.headers['authorization'] != "Bearer eyJhbGc") {
    return Response.forbidden('{"error":"Unauthenticated"}');
  }

  final messageId = int.tryParse(request.params['messageId'] ?? '');
  if (messageId == null) Response.notFound('message not found : $messageId');

  final message = Map.from(messages[messageId! - 1]);
  message['replies'] = replies(messageId);
  return Response.ok(jsonEncode(message, toEncodable: jsonEncoderHelper));
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final _handler = Pipeline()
      .addMiddleware(corsHeaders())
      .addMiddleware(logRequests())
      .addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${server.port}');
}

Object? jsonEncoderHelper(Object? item) {
  if (item is DateTime) return item.toIso8601String();
  return '$item';
}
