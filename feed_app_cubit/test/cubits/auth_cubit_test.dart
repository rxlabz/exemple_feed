import 'package:bloc_test/bloc_test.dart';
import 'package:feed_app_cubit/screens/auth_cubit.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/feed_test_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late AuthService authService;

  group('AuthCubit ', () {
    setUp(() {
      authService = MockAuthService();
      when(() => authService.login(
            mail: any(named: 'mail'),
            password: any(named: 'password'),
          )).thenAnswer((invocation) => Future.value(fakeUser));
    });

    blocTest<AuthCubit, AsyncTask<User?>>(
      'should login',
      build: () => AuthCubit(authService),
      act: (cubit) => cubit.login(
        mail: 'test@mail.com',
        password: 'azertyui',
      ),
      expect: () => [
        const AsyncTask<User?>.loading(),
        const AsyncTask<User?>.result(fakeUser),
      ],
    );

    blocTest<AuthCubit, AsyncTask<User?>>(
      'should logout',
      build: () => AuthCubit(authService),
      act: (cubit) => cubit.logout(),
      expect: () => [
        const AsyncTask<User?>.result(null),
      ],
    );
  });

  group('AuthCubit loginerror', () {
    setUp(() {
      authService = MockAuthService();

      when(() => authService.login(
            mail: any(named: 'mail'),
            password: any(named: 'password'),
          )).thenThrow(Exception('Service error'));
    });

    blocTest<AuthCubit, AsyncTask<User?>>(
      'should login',
      build: () => AuthCubit(authService),
      act: (cubit) => cubit.login(
        mail: 'test@mail.com',
        password: 'azertyui',
      ),
      expect: () => [
        const AsyncTask<User?>.loading(),
        const AsyncTask<User?>.error(),
      ],
    );
  });
}
