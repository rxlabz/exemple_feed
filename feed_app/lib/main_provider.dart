import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provider global
/// fournit les controllers
class MainProvider extends StatefulWidget {
  final Widget child;

  final AuthService authService;

  const MainProvider(this.child, {required this.authService, Key? key})
      : super(key: key);

  @override
  State<MainProvider> createState() => _MainProviderState();
}

class _MainProviderState extends State<MainProvider> {
  late final AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = AuthController(widget.authService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authController),
        ProxyProvider<AuthController, FeedService>(
          update: (_, controller, service) =>
              FeedService(FeedClient(controller.user?.token)),
          lazy: true,
        ),
      ],
      child: widget.child,
    );
  }
}
