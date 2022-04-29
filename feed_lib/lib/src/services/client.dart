import 'package:http/http.dart' as http;

class FeedClient extends http.BaseClient {
  final String? _token;

  FeedClient(this._token, {http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Content-Type'] = 'application/json';
    if (_token != null) {
      request.headers['Authorization'] = _token!;
    }
    return _client.send(request);
  }
}
