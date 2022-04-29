import 'package:flutter/material.dart';

import 'buttons.dart';

class FeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;

  const FeedAppBar({required this.onLogout, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        centerTitle: true,
        title: const Icon(Icons.flutter_dash),
        actions: [
          LogoutButton(key: const Key('btLogout'), onLogout: onLogout),
        ],
      );

  @override
  Size get preferredSize => const Size.fromHeight(52);
}
