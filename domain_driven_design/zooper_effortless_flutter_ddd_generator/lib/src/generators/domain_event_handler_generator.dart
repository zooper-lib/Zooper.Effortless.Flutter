import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class DomainEventHandlerGenerator extends Generator {
  final List<String> _globalImports = [];
  final List<String> _classImports = [];
  final List<String> _classRegistrations = [];

  static final Map<DartType, ClassElement> collectedData = {};

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    _findAndRegisterClasses(library, buildStep);

    _generateLibraryImports();

    _generateClassImportList(buildStep);

    _generateClassRegistrationList(library, buildStep);

    return _generateOutput();
  }

  void _findAndRegisterClasses(LibraryReader library, BuildStep buildStep) {
    for (var classElement in library.allElements.whereType<ClassElement>()) {
      if (_isDomainEventHandler(classElement)) {
        final eventType = _getEventDartType(classElement);

        collectedData[eventType] = classElement;
      }
    }
  }

  String _generateOutput() {
    final buffer = StringBuffer();

    // generate the global imports
    for (var import in _globalImports) {
      buffer.writeln(import);
    }

    // generate the class imports
    for (var import in _classImports) {
      buffer.writeln(import);
    }

    // Write the registerGeneratedHandlers function
    buffer.writeln('void registerGeneratedHandlers() {');

    // generate the class registrations+
    for (var registration in _classRegistrations) {
      buffer.writeln(registration);
    }

    // Close the registerGeneratedHandlers function
    buffer.writeln('}');

    return buffer.toString();
  }

  void _generateLibraryImports() {
    _globalImports.add("import 'package:get_it/get_it.dart';");
    _globalImports.add("import 'path/to/domain_event_handler.dart';");
  }

  void _generateClassImportList(BuildStep buildStep) {
    for (var entry in collectedData.entries) {
      final importStatement = _generateClassImport(entry.value, buildStep);

      _classImports.add(importStatement);
    }
  }

  String _generateClassImport(ClassElement classElement, BuildStep buildStep) {
    final packageName = buildStep.inputId.package;
    final filePath = classElement.source.uri.path; // Assuming the classElement comes from a source in lib/
    final relativePath = filePath.replaceFirst('lib/', ''); // Remove 'lib/'

    return "import 'package:$packageName/$relativePath';";
  }

  void _generateClassRegistrationList(LibraryReader library, BuildStep buildStep) {
    for (var classElement in library.allElements.whereType<ClassElement>()) {
      if (_isDomainEventHandler(classElement)) {
        final eventType = _getEventType(classElement);
        _classRegistrations.add('GetIt.I.registerSingleton<DomainEventHandler<$eventType>>(${classElement.name}());');
      }
    }
  }

  bool _isDomainEventHandler(ClassElement classElement) {
    return classElement.interfaces.any((interfaceType) {
      return interfaceType.element.name == 'DomainEventHandler' &&
          interfaceType.element.library.isDartCore == false &&
          interfaceType.typeArguments.length == 1;
    });
  }

  String _getEventType(ClassElement classElement) {
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

  DartType _getEventDartType(ClassElement classElement) {
    // Find the interface that matches `DomainEventHandler`
    var domainEventHandlerInterface = classElement.interfaces.firstWhere(
      (interfaceType) => interfaceType.element.name == 'DomainEventHandler',
      orElse: () => throw Exception('No DomainEventHandler interface found for ${classElement.name}'),
    );

    // Assuming the first type argument is the event type (T in DomainEventHandler<T>)
    var eventType = domainEventHandlerInterface.typeArguments.first;

    // Return the event type as a string, including handling for generic types if necessary
    return eventType;
  }
}
