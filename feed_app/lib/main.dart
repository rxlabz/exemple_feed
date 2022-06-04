import 'package:feed_lib/feed_lib.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'main_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MainProvider(const FeedApp(), authService: AuthService()));
}
