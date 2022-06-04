import 'package:flutter/material.dart';

import 'buttons.dart';

class FeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;
  final VoidCallback? onBack;

  const FeedAppBar({required this.onLogout, this.onBack, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        centerTitle: true,
        leading: onBack != null
            ? BackButton(onPressed: onBack)
            : const SizedBox.shrink(),
        title: const Icon(Icons.flutter_dash),
        actions: [
          LogoutButton(key: const Key('btLogout'), onLogout: onLogout),
        ],
      );

  @override
  Size get preferredSize => const Size.fromHeight(52);
}
