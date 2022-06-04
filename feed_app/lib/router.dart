import 'package:feed_lib/feed_lib.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/detail_screen.dart';
import 'screens/error_screen.dart';
import 'screens/feedlist_controller.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

GoRouter buildRouter(AuthController controller) => GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, GoRouterState state) {
            final service = context.read<FeedService>();
            final controller = FeedController()
              ..service = service
              ..loadAllMessages();
            return ChangeNotifierProvider.value(
              value: controller,
              child: const HomeScreen(),
            );
          },
          routes: [
            GoRoute(
              path: 'message/:id',
              builder: (context, GoRouterState state) {
                final messageId = int.tryParse(state.params['id'] ?? '');

                if (messageId == null) return const ErrorScreen();

                final controller = FeedController()
                  ..service = context.read<FeedService>()
                  ..loadMessage(messageId);

                return ChangeNotifierProvider.value(
                  value: controller,
                  child: DetailsScreen(messageId: messageId),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          builder: (context, GoRouterState state) => LoginScreen(),
        ),
      ],
      redirect: (state) {
        final user = controller.user;
        if (user == null && state.subloc != '/login') {
          return '/login';
        }

        if (user != null && state.subloc == '/login') {
          return '/';
        }

        return null;
      },
      refreshListenable: controller,
    );
