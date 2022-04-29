import 'package:feed_lib/feed_lib.dart';
import 'package:feed_test_lib/fake_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alchemist/alchemist.dart';
import 'package:golden_toolkit/golden_toolkit.dart' show loadAppFonts;

void main() {
  group('Message tile', () {
    setUp(() async {
      await loadAppFonts();
    });

    goldenTest(
      'renders',
      fileName: 'message_tile',
      constraints: const BoxConstraints(maxWidth: 400),
      builder: () => GoldenTestGroup(
        columnWidthBuilder: (_) => const FlexColumnWidth(),
        children: [
          GoldenTestScenario(
            name: 'message',
            child: MessageTile(
              message: fakeMessage,
              index: 0,
              onTap: () {},
            ),
          )
        ],
      ),
    );
  });
}
