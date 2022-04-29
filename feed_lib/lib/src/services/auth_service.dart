import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user.dart';

class AuthService {
  final http.Client _client;

  AuthService({http.Client? client}) : _client = client ?? http.Client();

  Future<User?> login({required String mail, required String password}) async {
    final result = await _client.post(
      Uri.parse('http://localhost:8080/login'),
      body: jsonEncode({'mail': mail, 'password': password}),
    );

    return result.body != 'null'
        ? User.fromJson(jsonDecode(result.body))
        : null;
  }
}
