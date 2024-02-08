import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

// Global accumulator for registration lines
final _registrations = <String>[];

class AggregateRegistrationsBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
        // This tells the build system to process every Dart file
        '.dart': ['.aggregate_registrations.dart']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Process each library file
    final library = await buildStep.inputLibrary;
    for (final classElement in library.topLevelElements.whereType<ClassElement>()) {
      if (isDomainEventHandler(classElement)) {
        final eventType = getEventType(classElement);
        _registrations.add('GetIt.I.registerSingleton<DomainEventHandler<$eventType>>(${classElement.name}());');
      }
    }

    // At the end of all builds, write the registrations to a file
    if (buildStep.inputId.path.endsWith('some_trigger_file.dart')) {
      final outputId = AssetId(buildStep.inputId.package, 'lib/aggregate_registrations.dart');
      await buildStep.writeAsString(outputId, _generateOutput());
    }
  }

  String _generateOutput() {
    return '''
      // GENERATED CODE - DO NOT MODIFY BY HAND

      void registerGeneratedHandlers() {
        ${_registrations.join('\n  ')}
      }
      ''';
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
