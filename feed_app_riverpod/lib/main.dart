import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';

void main() => runApp(const ProviderScope(child: FeedApp()));

class FeedApp extends ConsumerWidget {
  const FeedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider);

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
