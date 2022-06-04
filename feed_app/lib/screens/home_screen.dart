import 'package:feed_app/screens/feedlist_controller.dart';
import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// charge et affiche la liste des messages
/// permet d'ouvrir une popup de rédaction
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: FeedAppBar(
          onLogout: context.read<AuthController>().logout,
        ),
        floatingActionButton: const NewMessageAsyncButton(key: Key('btAdd')),
        body: const _Feedlist(),
      );
}

class _Feedlist extends StatelessWidget {
  const _Feedlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Selector<FeedController, AsyncTask<List<Message>>>(
        selector: (_, controller) => controller.loadAllTask,
        builder: (context, task, _) => task.when(
          result: (messages) => ListView.separated(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
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
      Selector<FeedController, AsyncTask<Message?>>(
        selector: (_, controller) => controller.sendMessageTask,
        builder: (context, task, _) => FloatingActionButton(
          child: task.when(
            result: (value) => const Icon(Icons.add),
            loading: () => const CircularProgressIndicator(
              color: Colors.white,
            ),
            error: (_) => const Icon(Icons.warning),
          ),
          onPressed: task.when(
            result: (value) {
              return () async {
                final user = context.read<AuthController>().user!;
                final messageContent = await showDialog(
                  context: context,
                  builder: (context) => NewMessageDialog(
                    onValue: Navigator.of(context).pop<String?>,
                  ),
                );
                if (messageContent?.isNotEmpty == true) {
                  await context.read<FeedController>().sendMessage(
                        Message(
                          name: user.name,
                          date: DateTime.now(),
                          message: messageContent,
                        ),
                      );
                  context.read<FeedController>().loadAllMessages();
                }
              };
            },
            loading: () => null,
            error: (error) => null,
          ),
        ),
      );
}
