import 'package:get_it/get_it.dart';
import 'package:zooper_effortless_flutter_di/zooper_effortless_flutter_di.dart';

class GetItServiceLocatorAdapter implements ServiceLocatorAdapter {
  final GetIt _getIt = GetIt.instance;

  @override
  T get<T extends Object>() {
    return _getIt.get<T>();
  }

  @override
  T getNamed<T extends Object>(String name) {
    return _getIt.get<T>(instanceName: name);
  }

  @override
  void register<T extends Object>(T instance) {
    _getIt.registerSingleton<T>(instance);
  }

  @override
  void registerAsync<T extends Object>(Future<T> Function() asyncFactory) {
    _getIt.registerSingletonAsync<T>(asyncFactory);
  }

  @override
  void registerSingleton<T extends Object>(T instance) {
    _getIt.registerSingleton<T>(instance);
  }

  @override
  void registerSingletonAsync<T extends Object>(Future<T> Function() asyncFactory) {
    _getIt.registerSingletonAsync<T>(asyncFactory);
  }

  @override
  void registerFactory<T extends Object>(T Function() factory) {
    _getIt.registerFactory<T>(factory);
  }

  @override
  void registerFactoryAsync<T extends Object>(Future<T> Function() asyncFactory) {
    _getIt.registerFactoryAsync<T>(asyncFactory);
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() factory) {
    _getIt.registerLazySingleton<T>(factory);
  }

  @override
  void registerLazySingletonAsync<T extends Object>(Future<T> Function() asyncFactory) {
    _getIt.registerLazySingletonAsync<T>(asyncFactory);
  }

  @override
  void registerConditional<T extends Object>(T Function() factory, bool Function()? condition) {
    throw UnimplementedError('Conditional registration is not supported by GetIt');
  }

  @override
  void registerConditionalAsync<T extends Object>(Future<T> Function() asyncFactory, bool Function()? condition) {
    throw UnimplementedError('Conditional registration is not supported by GetIt');
  }

  @override
  void registerNamed<T extends Object>(String name, T instance) {
    _getIt.registerSingleton<T>(instance, instanceName: name);
  }

  @override
  void registerNamedAsync<T extends Object>(String name, Future<T> Function() asyncFactory) {
    throw UnimplementedError('Named asynchronous registration is not supported by GetIt');
  }

  @override
  void unregister<T extends Object>() {
    _getIt.unregister<T>();
  }

  @override
  void unregisterNamed<T extends Object>(String name) {
    _getIt.unregister<T>(instanceName: name);
  }

  @override
  void clearAll() {
    _getIt.reset();
  }

  @override
  void dispose() {
    throw UnimplementedError('Disposing is not supported by GetIt');
  }

  @override
  void overrideInstance<T extends Object>(T instance) {
    _getIt.unregister<T>();
    _getIt.registerSingleton<T>(instance);
  }
}
