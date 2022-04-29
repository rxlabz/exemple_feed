import 'package:feed_app/router.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router.dart';
import 'screens/feedlist_controller.dart';

void main() {
  runApp(MainProvider(
    const FeedApp(),
    authService: AuthService(),
  ));
}

/// Provider global
/// fournit les controllers
class MainProvider extends StatelessWidget {
  final Widget child;

  final AuthService authService;

  const MainProvider(this.child, {required this.authService, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthController(authService);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authController),
        ProxyProvider<AuthController, FeedService>(
          update: (_, controller, service) =>
              FeedService(FeedClient(controller.user?.token)),
          lazy: true,
        ),
        ChangeNotifierProxyProvider<FeedService, FeedController>(
          create: (_) => FeedController(),
          update: (_, service, controller) =>
              FeedController()..service = service,
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}

class FeedApp extends StatelessWidget {
  const FeedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // initialisation du router

    final router = buildRouter(context.read<AuthController>());

    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: 'Feed',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
      ).copyWith(
        cardTheme: CardTheme(color: Colors.blueGrey.shade100),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
