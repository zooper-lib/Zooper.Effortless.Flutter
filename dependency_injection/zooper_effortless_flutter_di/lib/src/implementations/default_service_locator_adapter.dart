import 'package:zooper_effortless_flutter_di/zooper_effortless_flutter_di.dart';

class DefaultServiceLocatorAdapter implements ServiceLocatorAdapter {
  final Map<Type, dynamic> _services = {};
  final Map<Type, dynamic> _factories = {};
  final Map<Type, Future<dynamic> Function()> _asyncFactories = {};
  final Map<String, dynamic> _namedServices = {};
  final Map<String, Future<dynamic> Function()> _namedAsyncFactories = {};

  @override
  void clearAll() {
    _services.clear();
    _factories.clear();
    _asyncFactories.clear();
    _namedServices.clear();
    _namedAsyncFactories.clear();
  }

  @override
  void dispose() {
    // Implement disposal logic if any of your services need to be disposed.
  }

  @override
  T get<T extends Object>() {
    var service = _services[T];
    if (service != null) {
      return service as T;
    }

    var factory = _factories[T];
    if (factory != null) {
      service = (factory as T Function())();
      _services[T] = service;
      return service;
    }

    throw Exception('Service not found: ${T.toString()}');
  }

  @override
  T getNamed<T extends Object>(String name) {
    var service = _namedServices[name];
    if (service != null) {
      return service as T;
    }

    throw Exception('Named service not found: $name');
  }

  @override
  void overrideInstance<T extends Object>(T instance) {
    _services[T] = instance;
  }

  @override
  void register<T extends Object>(T instance) {
    _services[T] = instance;
  }

  @override
  Future<void> registerAsync<T extends Object>(Future<T> Function() asyncFactory) async {
    T instance = await asyncFactory();
    _services[T] = instance;
  }

  @override
  void registerConditional<T extends Object>(T Function() factory, bool Function() condition) {
    if (condition()) {
      _factories[T] = factory;
    }
  }

  @override
  Future<void> registerConditionalAsync<T extends Object>(
      Future<T> Function() asyncFactory, bool Function() condition) async {
    if (condition()) {
      T instance = await asyncFactory();
      _services[T] = instance;
    }
  }

  @override
  void registerFactory<T extends Object>(T Function() factory) {
    _factories[T] = factory;
  }

  @override
  void registerFactoryAsync<T extends Object>(Future<T> Function() asyncFactory) {
    _asyncFactories[T] = asyncFactory;
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() factory) {
    _factories[T] = () {
      var instance = _services[T];
      if (instance == null) {
        instance = factory();
        _services[T] = instance;
      }
      return instance;
    };
  }

  @override
  void registerLazySingletonAsync<T extends Object>(Future<T> Function() asyncFactory) {
    _asyncFactories[T] = asyncFactory;
  }

  @override
  void registerNamed<T extends Object>(String name, T instance) {
    _namedServices[name] = instance;
  }

  @override
  void registerNamedAsync<T extends Object>(String name, Future<T> Function() asyncFactory) {
    _namedAsyncFactories[name] = asyncFactory;
  }

  @override
  void registerSingleton<T extends Object>(T instance) {
    _services[T] = instance;
  }

  @override
  Future<void> registerSingletonAsync<T extends Object>(Future<T> Function() asyncFactory) async {
    T instance = await asyncFactory();
    _services[T] = instance;
  }

  @override
  void unregister<T extends Object>() {
    _services.remove(T);
    _factories.remove(T);
    _asyncFactories.remove(T);
  }

  @override
  void unregisterNamed<T extends Object>(String name) {
    _namedServices.remove(name);
    _namedAsyncFactories.remove(name);
  }

  // Additional helper methods for async retrieval
  Future<T> getAsync<T extends Object>() async {
    var service = _services[T];
    if (service != null) {
      return service as T;
    }

    var asyncFactory = _asyncFactories[T];
    if (asyncFactory != null) {
      service = await asyncFactory();
      _services[T] = service;
      return service as T;
    }

    throw Exception('Service not found: ${T.toString()}');
  }

  Future<T> getNamedAsync<T extends Object>(String name) async {
    var service = _namedServices[name];
    if (service != null) {
      return service as T;
    }

    var asyncFactory = _namedAsyncFactories[name];
    if (asyncFactory != null) {
      service = await asyncFactory();
      _namedServices[name] = service;
      return service as T;
    }

    throw Exception('Named service not found: $name');
  }
}
