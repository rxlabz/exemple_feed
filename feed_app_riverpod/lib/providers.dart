import 'package:feed_lib/feed_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'screens/detail_screen.dart';
import 'screens/error_screen.dart';
import 'screens/feedlist_controller.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authControllerProvider = ChangeNotifierProvider((ref) {
  final service = ref.watch(authServiceProvider);
  return AuthController(service);
});

final routerProvider = Provider<GoRouter>((ref) {
  final authController = ref.watch(authControllerProvider.notifier);

  return GoRouter(
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
      final user = authController.user;
      if (user == null && state.subloc != '/login') {
        return '/login';
      }

      if (user != null && state.subloc == '/login') {
        return '/';
      }

      return null;
    },
    refreshListenable: authController,
  );
});

final feedServiceProvider = Provider<FeedService>((ref) {
  final token = ref.watch(authControllerProvider).user?.token;
  final client = FeedClient(token);

  return FeedService(client);
});

final feedControllerProvider = ChangeNotifierProvider((ref) {
  final service = ref.watch(feedServiceProvider);

  return FeedController(service: service);
});
