import 'package:feed_app_cubit/screens/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feed_lib/feed_lib.dart';

import 'message_cubits.dart';

class DetailsScreen extends StatelessWidget {
  final int messageId;

  const DetailsScreen({required this.messageId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MessageCubit>().loadMessage(messageId);
    });

    return Scaffold(
      appBar: FeedAppBar(
        onLogout: context.read<AuthCubit>().logout,
      ),
      body: BlocBuilder<MessageCubit, AsyncTask<Message?>>(
        builder: (context, AsyncTask<Message?> state) {
          return state.when(
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
  const RepliesList({
    Key? key,
    required this.message,
  }) : super(key: key);

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
