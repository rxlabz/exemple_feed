import 'package:flutter/material.dart';

import '../model/message.dart';

class MessageTile extends StatelessWidget {
  final Message message;

  final int index;

  final VoidCallback onTap;

  const MessageTile({
    required this.message,
    required this.index,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key('tile$index'),
      leading: const Icon(Icons.account_circle),
      title: Text(message.name),
      subtitle: Text(message.message),
      onTap: onTap,
    );
  }
}
