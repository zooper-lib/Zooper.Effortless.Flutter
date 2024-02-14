import 'package:zef_di_abstractions/zef_di_abstractions.dart';

abstract class Registration<T extends Object> {
  final String? name;
  final dynamic key;
  final String? environment;

  Registration({
    required this.name,
    required this.key,
    required this.environment,
  });

  T resolve(ServiceLocator serviceLocator);
}

class SingletonRegistration<T extends Object> extends Registration<T> {
  final T instance;

  SingletonRegistration({
    required this.instance,
    required super.name,
    required super.key,
    required super.environment,
  });

  @override
  T resolve(ServiceLocator serviceLocator) => instance;
}

class FactoryRegistration<T extends Object> extends Registration<T> {
  final T Function(ServiceLocator serviceLocator) factory;

  FactoryRegistration({
    required this.factory,
    required super.name,
    required super.key,
    required super.environment,
  });

  @override
  T resolve(ServiceLocator serviceLocator) {
    return factory(serviceLocator);
  }
}
