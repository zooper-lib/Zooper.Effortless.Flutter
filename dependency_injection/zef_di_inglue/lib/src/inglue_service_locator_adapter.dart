import 'package:zef_di_abstractions/zef_di_abstractions.dart';
import 'package:zef_di_inglue/src/helpers/log_helper.dart';
import 'package:zef_di_inglue/src/helpers/user_messages.dart';
import 'package:zef_di_inglue/src/registration.dart';

class InglueServiceLocatorAdapter implements ServiceLocatorAdapter {
  final Map<Type, List<Registration>> _registrations = {};

  Map<Type, List<Registration>> get registrations => _registrations;

  @override
  void register<T extends Object>(
    T instance, {
    required List<Type>? interfaces,
    required String? name,
    required dynamic key,
    required String? environment,
  }) {
    if (name != null && isNamedRegistered(name)) {
      LogHelper.logWarning(registrationAlreadyExistsForTypeAndName(T, name));
      return;
    }

    var registration = SingletonRegistration<T>(
      instance: instance,
      interfaces: interfaces,
      name: name,
      key: key,
      environment: environment,
    );

    _registrations[T] ??= [];
    _registrations[T]!.add(registration);
  }

  @override
  List<T> getAll<T extends Object>({
    required Type? interface,
    required String? name,
    required key,
    required String? environment,
  }) {
    var allRegistrations = _registrations[T] ?? [];

    // Check if there are any registrations
    if (allRegistrations.isEmpty) {
      LogHelper.logInfo(noRegistrationFoundForType(T));
      return [];
    }

    // Filter by the interfaces
    if (interface != null) {
      allRegistrations = allRegistrations.where((registration) {
        return registration.interfaces!.contains(interface);
      }).toList();
    }

    // Filter by the name
    if (name != null) {
      allRegistrations = allRegistrations.where((registration) {
        return registration.name == name;
      }).toList();
    }

    // Filter by the key
    allRegistrations = allRegistrations.where((registration) {
      return registration.key == key;
    }).toList();

    // Filter by the environment
    if (environment != null) {
      allRegistrations = allRegistrations.where((registration) {
        return registration.environment == environment;
      }).toList();
    }

    // Resolve the instances
    var resolvedInstances = allRegistrations.map((registration) {
      return registration.resolve(ServiceLocator.I) as T;
    }).toList();

    return resolvedInstances;
  }

  @override
  T? getFirst<T extends Object>({
    required Type? interface,
    required String? name,
    required key,
    required String? environment,
  }) {
    var allInstances = getAll<T>(
      interface: interface,
      name: name,
      key: key,
      environment: environment,
    );

    if (allInstances.isEmpty) {
      LogHelper.logInfo(noRegistrationFoundForType(T));
      return null;
    }

    return allInstances.first;
  }

  bool isNamedRegistered(String name) {
    return _registrations.values.any((element) => element.any((element) => element.name == name));
  }
}
