import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:zooper_effortless_flutter_ddd_generator/zooper_effortless_flutter_ddd_generator.dart';

class DomainEventHandlerGenerator extends GeneratorForAnnotation<GenerateHandlerRegistration> {
  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    print('Running annotation processor for DomainEventHandlerGenerator');

    final libraryElements = await buildStep.resolver.libraries.toList();

    for (final library in libraryElements) {
      // Avoid scanning non-user libraries (e.g., Dart SDK and packages)
      if (!library.isInSdk && !library.source.uri.toString().contains('package:')) {
        for (final classElement in library.classes) {
          if (classElement.interfaces.any((interfaceType) => interfaceType.element2.name == 'MyInterface')) {
            // Class implements MyInterface, add it to the buffer
            buffer.writeln('${classElement.name},');
          }
        }
      }
    }

    if (element is ClassElement && isDomainEventHandler(element)) {
      print('Generating for ${element.name}');

      final eventType = getEventType(element);
      final className = element.name;

      // Add data to the global collector
      GlobalCollector.collectedData[eventType] = className;
    }

    // At this point, all annotations in the current library have been processed
    // Generate aggregated output for this library
    //return generateAggregatedOutput(buildStep);
  }

  String generateAggregatedOutput(BuildStep buildStep) {
    final buffer = StringBuffer();

    GlobalCollector.collectedData.forEach((eventType, className) {
      buffer.writeln('// Handler for $eventType is $className');
    });

    // Generate a part file for this library or a standalone file as needed
    // For a part file, use:
    // final fileName = buildStep.inputId.path.replaceAll('.dart', '.g.dart');
    // For a standalone file, you might need to ensure uniqueness and write to 'lib/'

    return buffer.toString();
  }

  bool isDomainEventHandler(ClassElement classElement) {
    return classElement.interfaces.any((interfaceType) {
      return interfaceType.element.name == 'DomainEventHandler' &&
          interfaceType.element.library.isDartCore == false &&
          interfaceType.typeArguments.length == 1 &&
          interfaceType.typeArguments.first.element is ClassElement; // The type argument should be a class type
    });
  }

  String getEventType(ClassElement classElement) {
    // Find the interface that matches `DomainEventHandler`
    var domainEventHandlerInterface = classElement.interfaces.firstWhere(
      (interfaceType) => interfaceType.element.name == 'DomainEventHandler',
      orElse: () => throw Exception('No DomainEventHandler interface found for ${classElement.name}'),
    );

    // Assuming the first type argument is the event type (T in DomainEventHandler<T>)
    var eventType = domainEventHandlerInterface.typeArguments.first;

    // Return the event type as a string, including handling for generic types if necessary
    return eventType.getDisplayString(withNullability: false);
  }
}
