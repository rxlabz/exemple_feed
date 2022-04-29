import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutButton({required this.onLogout, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onLogout,
        icon: const Icon(Icons.logout),
      );
}
