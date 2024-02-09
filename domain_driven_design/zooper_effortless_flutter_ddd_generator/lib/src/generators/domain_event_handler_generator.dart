import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:zooper_effortless_flutter_ddd_generator/zooper_effortless_flutter_ddd_generator.dart';
import 'package:glob/glob.dart';

class DomainEventHandlerGenerator extends GeneratorForAnnotation<HandlerAggregate> {
  final List<String> _globalImports = [];
  final List<String> _classImports = [];
  final List<String> _classRegistrations = [];

  static final Map<DartType, ClassElement> collectedData = {};

  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    await _findAndRegisterClasses2(buildStep);

    _generateLibraryImports();

    _generateClassImportList(buildStep);

    await _generateClassRegistrationList(buildStep);

    return _generateOutput();
  }

  Future<void> _findAndRegisterClasses2(BuildStep buildStep) async {
    await for (final input in buildStep.findAssets(Glob('lib/**/*.dart'))) {
      final library = await buildStep.resolver.libraryFor(input);

      for (var classElement in library.topLevelElements.whereType<ClassElement>()) {
        if (_isDomainEventHandler(classElement)) {
          final eventType = _getEventDartType(classElement);

          collectedData[eventType] = classElement;
        }
      }
    }

    print('Found ${collectedData.length} classes');
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
    _globalImports.add("import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';");
  }

  void _generateClassImportList(BuildStep buildStep) {
    for (var entry in collectedData.entries) {
      final eventType = entry.key;
      final handlerClassElement = entry.value;

      // Generate import for the handler
      final handlerImportStatement = _generateClassImport(handlerClassElement, buildStep);
      if (!_classImports.contains(handlerImportStatement)) {
        _classImports.add(handlerImportStatement);
      }

      // Generate import for the event, assuming the event type is a ClassElement
      if (eventType.element is ClassElement) {
        final eventClassElement = eventType.element as ClassElement;
        final eventImportStatement = _generateClassImport(eventClassElement, buildStep);
        if (!_classImports.contains(eventImportStatement)) {
          _classImports.add(eventImportStatement);
        }
      }
    }
  }

  String _generateClassImport(ClassElement classElement, BuildStep buildStep) {
    final filePath = classElement.source.uri.path;
    final relativePath = filePath.replaceFirst('lib/', '');

    return "import 'package:$relativePath';";
  }

  Future<void> _generateClassRegistrationList(BuildStep buildStep) async {
    await for (final input in buildStep.findAssets(Glob('lib/**/*.dart'))) {
      final library = await buildStep.resolver.libraryFor(input);

      for (var classElement in library.topLevelElements.whereType<ClassElement>()) {
        if (_isDomainEventHandler(classElement)) {
          final eventType = _getEventType(classElement);
          _classRegistrations.add('GetIt.I.registerSingleton<DomainEventHandler<$eventType>>(${classElement.name}());');
        }
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
