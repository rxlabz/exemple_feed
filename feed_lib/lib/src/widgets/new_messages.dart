import 'package:flutter/material.dart';

/// dialog de rédaction d'un message
class NewMessageDialog extends StatelessWidget {
  final ValueChanged<String?> onValue;

  const NewMessageDialog({required this.onValue, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return AlertDialog(
      title: const Text('Nouveau message'),
      content: TextFormField(
        key: const Key('fieldMessage'),
        controller: controller,
        maxLines: 4,
        decoration: const InputDecoration(
          labelText: 'Votre message',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          key: const Key('btCancel'),
          onPressed: () => onValue(null),
          child: const Text('Annuler'),
        ),
        // désactive le bouton quand le champ est vide
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, widget) => ElevatedButton(
            key: const Key('btSend'),
            onPressed:
                value.text.isNotEmpty ? () => onValue(controller.text) : null,
            child: const Text('Envoyer'),
          ),
        ),
      ],
    );
  }
}
