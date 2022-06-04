import 'package:feed_app_cubit/screens/message_cubits.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'auth_cubit.dart';

/// charge et affiche la liste des messages
/// permet d'ouvrir une popup de rédaction
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FeedAppBar(
        onLogout: context.read<AuthCubit>().logout,
      ),
      floatingActionButton: const NewMessageAsyncButton(key: Key('btAdd')),
      body: const _Feedlist(),
    );
  }
}

class _Feedlist extends StatelessWidget {
  const _Feedlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeCubit, AsyncTask<List<Message>>>(
        builder: (context, state) => state.when(
          result: (result) => ListView.separated(
            itemCount: result.length,
            itemBuilder: (context, index) {
              final message = result[index];
              return MessageTile(
                index: index,
                message: message,
                onTap: () => context.push('/message/${message.id}'),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Center(child: Text(message)),
        ),
      );
}

/// bouton d'ouverture de la popup de rédaction de nouveau message
/// - affiche un spinner durant l'envoi du message
/// - bloque le bouton en cas de chargement ou d'erreur
class NewMessageAsyncButton extends StatelessWidget {
  const NewMessageAsyncButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SendMessageCubit, AsyncTask<Message?>>(
        builder: (context, state) => FloatingActionButton(
          child: state.when(
            result: (value) => const Icon(Icons.add),
            loading: () => const CircularProgressIndicator(
              color: Colors.white,
            ),
            error: (_) => const Icon(Icons.warning),
          ),
          onPressed: state.when(
            result: (value) => () async {
              context.read<AuthCubit>().state.when(
                    result: (user) async {
                      final messageContent = await showDialog(
                        context: context,
                        builder: (context) => NewMessageDialog(
                          onValue: Navigator.of(context).pop<String?>,
                        ),
                      );
                      if (messageContent?.isNotEmpty == true) {
                        await context.read<SendMessageCubit>().sendMessage(
                              Message(
                                name: user.name,
                                date: DateTime.now(),
                                message: messageContent,
                              ),
                            );
                        context.read<HomeCubit>().loadAll();
                      }
                    },
                    loading: () => null,
                    error: (err) => null,
                  );
            },
            loading: () => null,
            error: (error) => null,
          ),
        ),
      );
}
