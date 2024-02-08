import 'package:zooper_effortless_flutter_di/src/implementations/default_service_locator_adapter.dart';
import 'package:zooper_effortless_flutter_di/src/interfaces/service_locator_adapter.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  static ServiceLocatorAdapter _adapter = DefaultServiceLocatorAdapter();

  // Private constructor
  ServiceLocator._internal();

  // Public factory constructor to return the instance
  factory ServiceLocator() {
    return _instance;
  }

  /// Static method to access the instance
  static ServiceLocator get instance => _instance;

  /// Static method to access the instance in a short way
  static ServiceLocator get I => _instance;

  /// Sets the service locator adapter.
  void setAdapter(ServiceLocatorAdapter adapter) {
    _adapter = adapter;
  }

  /// Retrieves an instance of type [T].
  T get<T extends Object>() => _adapter.get<T>();

  /// Retrieves a named instance of type [T].
  T getNamed<T extends Object>(String name) => _adapter.getNamed<T>(name);

  /// Registers an instance of type [T].
  void register<T extends Object>(T instance) => _adapter.register<T>(instance);

  /// Registers an asynchronous factory for type [T].
  void registerAsync<T extends Object>(Future<T> Function() asyncFactory) => _adapter.registerAsync<T>(asyncFactory);

  /// Registers a singleton instance of type [T].
  void registerSingleton<T extends Object>(T instance) => _adapter.registerSingleton<T>(instance);

  /// Registers a singleton instance of type [T] asynchronously.
  void registerSingletonAsync<T extends Object>(Future<T> Function() asyncFactory) =>
      _adapter.registerSingletonAsync<T>(asyncFactory);

  /// Registers a factory for creating new instances of type [T].
  void registerFactory<T extends Object>(T Function() factory) => _adapter.registerFactory<T>(factory);

  /// Registers an asynchronous factory for creating new instances of type [T].
  void registerFactoryAsync<T extends Object>(Future<T> Function() asyncFactory) =>
      _adapter.registerFactoryAsync<T>(asyncFactory);

  /// Registers a lazy singleton of type [T], instantiated on first use.
  void registerLazySingleton<T extends Object>(T Function() factory) => _adapter.registerLazySingleton<T>(factory);

  /// Registers a lazy singleton of type [T] asynchronously, instantiated on first use.
  void registerLazySingletonAsync<T extends Object>(Future<T> Function() asyncFactory) =>
      _adapter.registerLazySingletonAsync<T>(asyncFactory);

  /// Registers a factory of type [T] conditionally, based on [condition].
  void registerConditional<T extends Object>(T Function() factory, bool Function() condition) =>
      _adapter.registerConditional<T>(factory, condition);

  /// Registers an asynchronous factory of type [T] conditionally, based on [condition].
  void registerConditionalAsync<T extends Object>(Future<T> Function() asyncFactory, bool Function() condition) =>
      _adapter.registerConditionalAsync<T>(asyncFactory, condition);

  /// Registers a named instance of type [T].
  void registerNamed<T extends Object>(String name, T instance) => _adapter.registerNamed<T>(name, instance);

  /// Registers a named asynchronous factory of type [T].
  void registerNamedAsync<T extends Object>(String name, Future<T> Function() asyncFactory) =>
      _adapter.registerNamedAsync<T>(name, asyncFactory);

  /// Unregisters instances of type [T].
  void unregister<T extends Object>() => _adapter.unregister<T>();

  /// Unregisters named instances of type [T].
  void unregisterNamed<T extends Object>(String name) => _adapter.unregisterNamed<T>(name);

  /// Clears all registered instances and resources.
  void clearAll() => _adapter.clearAll();

  /// Disposes of the service locator, freeing up resources and unregistering all instances.
  void dispose() => _adapter.dispose();

  /// Overrides an existing registration with a new instance of type [T].
  void overrideInstance<T extends Object>(T instance) => _adapter.overrideInstance<T>(instance);
}
