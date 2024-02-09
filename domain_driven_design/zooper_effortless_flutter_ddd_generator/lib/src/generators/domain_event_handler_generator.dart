import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class DomainEventHandlerGenerator extends Generator {
  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final buffer = StringBuffer();

    print('Generating: "void registerGeneratedHandlers2() {"');
    buffer.writeln('void registerGeneratedHandlers2() {');

    // Iterate through all the classes in the library
    for (var classElement in library.allElements.whereType<ClassElement>()) {
      if (isDomainEventHandler(classElement)) {
        print('Found DomainEventHandler: ${classElement.name}');

        final eventType = getEventType(classElement);
        print('Found EventType: $eventType');

        print('Generating: "GetIt.I.registerSingleton<DomainEventHandler<$eventType>>(${classElement.name}());"');
        buffer.writeln('GetIt.I.registerSingleton<DomainEventHandler<$eventType>>(${classElement.name}());');
      }
    }

    print('Generating: "}"');
    buffer.writeln('}');

    print('Final Output: ${buffer.toString()}');
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
