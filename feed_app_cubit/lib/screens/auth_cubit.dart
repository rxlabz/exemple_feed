import 'package:bloc/bloc.dart';
import 'package:feed_lib/feed_lib.dart';

class AuthCubit extends Cubit<AsyncTask<User?>> {
  final AuthService _service;

  AuthCubit(this._service) : super(const AsyncTask<User?>.result(null));

  Future<void> login({required String mail, required String password}) async {
    emit(const AsyncTask.loading());

    try {
      final user = await _service.login(mail: mail, password: password);
      emit(user != null
          ? AsyncTask.result(user)
          : const AsyncTask.error(message: "Erreur d'identification"));
    } catch (err) {
      emit(const AsyncTask.error());
    }
  }

  void logout() => emit(const AsyncTask<User?>.result(null));
}
