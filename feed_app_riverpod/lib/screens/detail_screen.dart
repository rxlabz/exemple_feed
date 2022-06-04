import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class DetailsScreen extends ConsumerWidget {
  final int messageId;

  const DetailsScreen({required this.messageId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // chargement du message sélectionné
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(feedControllerProvider.notifier).loadMessage(messageId);
    });

    return Scaffold(
      appBar: FeedAppBar(
        onLogout: ref.watch(authControllerProvider.notifier).logout,
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final task = ref.watch(
            feedControllerProvider.select((value) => value.loadDetailsTask),
          );
          return task.when(
            result: (message) => message == null
                ? const SizedBox.shrink()
                : _MessageView(message),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message)),
          );
        },
      ),
    );
  }
}

class _MessageView extends StatelessWidget {
  final Message message;

  const _MessageView(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          MessageCard(message),
          Expanded(child: RepliesList(message: message))
        ],
      );
}

class RepliesList extends StatelessWidget {
  const RepliesList({required this.message, Key? key}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.only(left: 40),
        children: (message.replies ?? [])
            .map(
              (e) => ListTile(title: Text(e.name), subtitle: Text(e.message)),
            )
            .toList(),
      );
}

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.account_circle),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(message.name),
                    Text(message.message, textAlign: TextAlign.justify),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
