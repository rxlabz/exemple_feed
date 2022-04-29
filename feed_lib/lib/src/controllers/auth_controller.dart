import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/foundation.dart';

class AuthController extends ChangeNotifier {
  final AuthService _service;

  User? _user;

  User? get user => _user;

  AuthController(this._service);

  AsyncTask<User?>? _loginTask;

  AsyncTask<User?>? get loginTask => _loginTask;

  set loginTask(AsyncTask<User?>? value) {
    _loginTask = value;
    notifyListeners();
  }

  bool get hasError =>
      _loginTask?.maybeWhen(error: (message) => true, orElse: () => false) ??
      false;

  Future<void> login({required String mail, required String password}) async {
    loginTask = const AsyncTask.loading();

    try {
      final result = await _service.login(mail: mail, password: password);
      _user = result;
      loginTask = user != null
          ? AsyncTask.result(user)
          : const AsyncTask.error(message: "Erreur d'identification");
    } catch (err) {
      loginTask = const AsyncTask.error();
    }
  }

  void logout() {
    _user = null;
    loginTask = null;
  }
}
