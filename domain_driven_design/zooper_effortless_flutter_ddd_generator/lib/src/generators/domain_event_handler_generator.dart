import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:zooper_effortless_flutter_ddd_generator/src/helpers/global_collector.dart';

class DomainEventHandlerGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    // Iterate through all the classes in the library
    for (var classElement in library.allElements.whereType<ClassElement>()) {
      if (isDomainEventHandler(classElement)) {
        final eventType = getEventType(classElement);

        GlobalCollector.collectedData[eventType] = classElement.name;
      }
    }

    return _generateOutput();
  }

  String _generateOutput() {
    final buffer = StringBuffer();

    buffer.writeln('void registerGeneratedHandlers() {');

    for (var entry in GlobalCollector.collectedData.entries) {
      buffer.writeln('GetIt.I.registerSingleton<DomainEventHandler<${entry.key}>>(${entry.value}());');
    }

    buffer.writeln('}');

    return buffer.toString();
  }

  bool isDomainEventHandler(ClassElement classElement) {
    return classElement.interfaces.any((interfaceType) {
      return interfaceType.element.name == 'DomainEventHandler' &&
          interfaceType.element.library.isDartCore == false &&
          interfaceType.typeArguments.length == 1;
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
