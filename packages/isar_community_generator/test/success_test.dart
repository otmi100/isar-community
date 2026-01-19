import 'dart:io';

import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:isar_community_generator/isar_generator.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

void main() {
  group('Success case', () {
    for (final file in Directory('test/success').listSync(recursive: true)) {
      if (file is! File || !file.path.endsWith('.dart')) continue;

      test(file.path, () async {
        final content = await file.readAsLines();

        final errorMessage = content.first.split('//').last.trim();

        String? error;
        try {
          await testBuilder(
            getIsarGenerator(BuilderOptions.empty),
            {'a|${file.path}': content.join('\n')},
            reader: await PackageAssetReader.currentIsolate(),
          );
        } on Exception catch (e) {
          error = e.toString();
        }

        expect(error, isNull);
      });
    }
  });
}
