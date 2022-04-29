import 'dart:convert';

import '../model/message.dart';
import 'package:http/http.dart' as http;

class FeedService {
  final http.Client _client;

  final String baseUrl;

  FeedService(this._client, {this.baseUrl = 'http://localhost:8080'});

  Future<List<Message>> loadAll() async {
    final result = await _client.get(Uri.parse('$baseUrl/messages'));

    return List.from(jsonDecode(result.body))
        .map((e) => Message.fromJson(e))
        .toList();
  }

  Future<Message> loadMessage(int messageId) async {
    final result = await _client.get(Uri.parse('$baseUrl/message/$messageId'));

    return Message.fromJson(jsonDecode(result.body));
  }

  Future<Message> sendMessage(Message message) async {
    final result = await _client.post(
      Uri.parse('$baseUrl/message'),
      body: jsonEncode(message.toJson()),
    );

    return Message.fromJson(jsonDecode(result.body));
  }
}
