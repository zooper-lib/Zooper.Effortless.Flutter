import 'package:build/build.dart';
import 'package:zooper_effortless_flutter_ddd_generator/zooper_effortless_flutter_ddd_generator.dart';

class AggregateBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '.dummy': ['.aggregate.dart'],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    print('Building aggregate registry');

    final buffer = StringBuffer()
      ..writeln('class GeneratedRegistry {')
      ..writeln('  static final Map<String, String> registry = {');

    GlobalCollector.collectedData.forEach((eventType, className) {
      buffer.writeln('    "$eventType": "$className",');
    });

    buffer
      ..writeln('  };')
      ..writeln('}');

    // Write the aggregated data to a single file
    await buildStep.writeAsString(
      AssetId(buildStep.inputId.package, 'lib/generated_registry.dart'),
      buffer.toString(),
    );
  }
}
