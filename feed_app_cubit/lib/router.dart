import 'package:go_router/go_router.dart';

import 'screens/detail_screen.dart';
import 'screens/error_screen.dart';
import 'screens/home_screen.dart';
import 'screens/auth_cubit.dart';
import 'screens/login_screen.dart';

GoRouter buildRouter(AuthCubit authCubit) => GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, GoRouterState state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'message/:id',
              builder: (context, GoRouterState state) {
                final messageId = int.tryParse(state.params['id'] ?? '');

                if (messageId == null) return const ErrorScreen();

                return DetailsScreen(messageId: messageId);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          builder: (context, GoRouterState state) {
            return LoginScreen();
          },
        ),
      ],
      redirect: (state) {
        return authCubit.state.when(
          result: (user) {
            if (user == null && state.subloc != '/login') {
              return '/login';
            }

            if (user != null && state.subloc == '/login') {
              return '/';
            }
          },
          loading: () => null,
          error: (error) => null,
        );
      },
      refreshListenable: GoRouterRefreshStream(authCubit.stream),
    );
