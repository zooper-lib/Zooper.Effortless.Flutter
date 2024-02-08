abstract class ServiceLocatorAdapter {
  /// Retrieves an instance of type [T].
  T get<T extends Object>();

  /// Retrieves a named instance of type [T] using the provided [name].
  T getNamed<T extends Object>(String name);

  /// Registers an instance of type [T].
  void register<T extends Object>(T instance);

  /// Registers an asynchronous factory for type [T].
  void registerAsync<T extends Object>(Future<T> Function() asyncFactory);

  /// Registers a singleton instance of type [T].
  void registerSingleton<T extends Object>(T instance);

  /// Registers a singleton instance of type [T] asynchronously.
  void registerSingletonAsync<T extends Object>(Future<T> Function() asyncFactory);

  /// Registers a factory for creating new instances of type [T].
  void registerFactory<T extends Object>(T Function() factory);

  /// Registers an asynchronous factory for creating new instances of type [T].
  void registerFactoryAsync<T extends Object>(Future<T> Function() asyncFactory);

  /// Registers a lazy singleton of type [T], instantiated on first use.
  void registerLazySingleton<T extends Object>(T Function() factory);

  /// Registers a lazy singleton of type [T] asynchronously, instantiated on first use.
  void registerLazySingletonAsync<T extends Object>(Future<T> Function() asyncFactory);

  /// Registers a factory of type [T] conditionally, based on [condition].
  void registerConditional<T extends Object>(T Function() factory, bool Function() condition);

  /// Registers an asynchronous factory of type [T] conditionally, based on [condition].
  void registerConditionalAsync<T extends Object>(Future<T> Function() asyncFactory, bool Function() condition);

  /// Registers a named instance of type [T] using the provided [name].
  void registerNamed<T extends Object>(String name, T instance);

  /// Registers a named asynchronous factory of type [T] using the provided [name].
  void registerNamedAsync<T extends Object>(String name, Future<T> Function() asyncFactory);

  /// Unregisters instances of type [T].
  void unregister<T extends Object>();

  /// Unregisters named instances of type [T] using the provided [name].
  void unregisterNamed<T extends Object>(String name);

  /// Clears all registered instances.
  void clearAll();

  /// Disposes of the service locator, freeing up resources and unregistering all instances.
  void dispose();

  /// Overrides an existing registration with a new instance of type [T].
  void overrideInstance<T extends Object>(T instance);
}
