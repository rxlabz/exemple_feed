import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers.dart';

/// charge et affiche la liste des messages
/// permet d'ouvrir une popup de rédaction
class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // lance le chargement des messages
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(feedControllerProvider.notifier).loadAllMessages();
    });

    return Scaffold(
      appBar: FeedAppBar(
        onLogout: ref.read(authControllerProvider).logout,
      ),
      floatingActionButton: const NewMessageAsyncButton(key: Key('btAdd')),
      body: const _Feedlist(),
    );
  }
}

class _Feedlist extends StatelessWidget {
  const _Feedlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer(
        builder: (context, ref, _) {
          final task = ref.watch(
            feedControllerProvider.select((value) => value.loadAllTask),
          );

          return task.when(
            result: (result) => ListView.separated(
              itemCount: result.length,
              itemBuilder: (context, index) {
                final message = result[index];
                return MessageTile(
                  message: message,
                  index: index,
                  onTap: () => context.push('/message/${message.id}'),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message)),
          );
        },
      );
}

/// bouton d'ouverture de la popup de rédaction de nouveau message
/// - affiche un spinner durant l'envoi du message
/// - bloque le bouton en cas de chargement ou d'erreur
class NewMessageAsyncButton extends ConsumerWidget {
  const NewMessageAsyncButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Consumer(
        builder: (context, ref, _) {
          final task = ref.watch(
            feedControllerProvider.select((value) => value.sendMessageTask),
          );

          return FloatingActionButton(
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
                  final user = ref.watch(authControllerProvider).user!;
                  final messageContent = await showDialog(
                    context: context,
                    builder: (context) => NewMessageDialog(
                      onValue: Navigator.of(context).pop<String?>,
                    ),
                  );
                  if (messageContent?.isNotEmpty == true) {
                    await ref
                        .watch(feedControllerProvider.notifier)
                        .sendMessage(
                          Message(
                            name: user.name,
                            date: DateTime.now(),
                            message: messageContent,
                          ),
                        );
                    ref
                        .watch(feedControllerProvider.notifier)
                        .loadAllMessages();
                  }
                };
              },
              loading: () => null,
              error: (error) => null,
            ),
          );
        },
      );
}
