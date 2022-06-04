import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'router.dart';
import 'screens/auth_cubit.dart';
import 'screens/message_cubits.dart';

void main() {
  runApp(MainProvider(
    child: const FeedApp(),
    authService: AuthService(),
    serviceBuilder: (client) => FeedService(client),
  ));
}

class MainProvider extends StatelessWidget {
  final Widget child;

  final AuthService authService;

  final FeedService Function(http.Client) serviceBuilder;

  const MainProvider({
    required this.authService,
    required this.serviceBuilder,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authService,
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (context) => AuthCubit(context.read<AuthService>()),
            child: AuthenticatedBlocProvider(
              child: child,
              serviceBuilder: serviceBuilder,
            ),
          );
        },
      ),
    );
  }
}

class AuthenticatedBlocProvider extends StatelessWidget {
  final Widget child;

  final FeedService Function(http.Client) serviceBuilder;

  const AuthenticatedBlocProvider({
    required this.child,
    required this.serviceBuilder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = context.watch<AuthCubit>().state.maybeWhen(
          result: (user) => user != null ? FeedClient(user.token) : null,
          orElse: () => null,
        );

    FeedService? feedService;
    if (client != null) feedService = serviceBuilder(client);

    return feedService == null
        ? child
        : MultiBlocProvider(
            providers: [
              BlocProvider<HomeCubit>(
                create: (context) => HomeCubit(feedService!)..loadAll(),
              ),
              BlocProvider<SendMessageCubit>(
                create: (context) => SendMessageCubit(feedService!),
              ),
              BlocProvider<MessageCubit>(
                create: (context) => MessageCubit(feedService!),
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
    final router = buildRouter(context.read<AuthCubit>());

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
