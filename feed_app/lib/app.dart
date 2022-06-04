import 'package:feed_lib/feed_lib.dart';

import 'router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
            backgroundColor: Colors.blueGrey.shade50),
      ).copyWith(
        cardTheme: CardTheme(color: Colors.blueGrey.shade100),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
