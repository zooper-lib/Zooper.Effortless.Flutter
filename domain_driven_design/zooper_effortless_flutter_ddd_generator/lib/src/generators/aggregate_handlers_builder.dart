import 'package:build/build.dart';

Builder aggregatedRegistrationBuilder(BuilderOptions options) => AggregatedRegistrationBuilder();

class AggregatedRegistrationBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        '.handler.g.dart': ['.aggregated_handlers.dart']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Logic to read the content of the .handler.g.dart file
    String content = await buildStep.readAsString(buildStep.inputId);

    // Logic to aggregate content. This might involve appending to a file,
    // or collecting content from multiple files and writing it once.

    // Example: Write the content to a new file
    final newAssetId = buildStep.inputId.changeExtension('.aggregated_handlers.dart');
    await buildStep.writeAsString(newAssetId, content);
  }
}
