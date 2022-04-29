import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:feed_lib/feed_lib.dart';

void main() {
  test('should be in initial state', () {
    final authService = MockAuthService();
    final controller = AuthController(authService);

    expect(controller.loginTask, null);
    expect(controller.user, null);
    expect(controller.hasError, false);
  });

  test('should be in error state if service throws', () async {
    final authService = MockAuthService();
    when(() => authService.login(
          mail: any(named: 'mail'),
          password: any(named: 'password'),
        )).thenThrow(Exception());

    final controller = AuthController(authService);

    await controller.login(mail: 'test@mail.com', password: 'azertyui');

    expect(controller.loginTask, const AsyncTask<User?>.error());
    expect(controller.hasError, true);
  });

  test('should be in authentication error state', () async {
    final authService = MockAuthService();
    when(() => authService.login(
          mail: any(named: 'mail'),
          password: any(named: 'password'),
        )).thenAnswer((_) => Future.value(null));

    final controller = AuthController(authService);

    await controller.login(mail: 'test@mail.com', password: 'azertyui');

    expect(
      controller.loginTask,
      const AsyncTask<User?>.error(message: "Erreur d'identification"),
    );

    expect(controller.hasError, true);
  });

  test('should be in logged state', () async {
    const user =
        User(id: 1, name: 'Joe', mail: "joe@ma.il", token: 'Bearer...');

    final authService = MockAuthService();
    when(() => authService.login(
          mail: any(named: 'mail'),
          password: any(named: 'password'),
        )).thenAnswer((_) => Future.value(user));

    final controller = AuthController(authService);

    await controller.login(mail: 'test@mail.com', password: 'azertyui');

    expect(controller.hasError, false);
    expect(controller.user != null, true);
    expect(controller.loginTask, const AsyncTask<User?>.result(user));
  });

  test('should logout', () async {
    const user =
        User(id: 1, name: 'Joe', mail: "joe@ma.il", token: 'Bearer...');

    final authService = MockAuthService();
    when(() => authService.login(
          mail: any(named: 'mail'),
          password: any(named: 'password'),
        )).thenAnswer((_) => Future.value(user));

    final controller = AuthController(authService);

    await controller.login(mail: 'test@mail.com', password: 'azertyui');

    expect(controller.hasError, false);
    expect(controller.user != null, true);
    expect(controller.loginTask, const AsyncTask<User?>.result(user));

    controller.logout();

    expect(controller.user, null);
    expect(controller.loginTask, null);
  });
}
