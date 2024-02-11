import 'package:zef_di_abstractions/zef_di_abstractions.dart';
import 'package:zef_di_inglue/src/registration.dart';

class InglueServiceLocatorAdapter implements ServiceLocatorAdapter {
  final List<Registration> _registrations = [];

  @override
  void clearAll() {
    _registrations.clear();
  }

  @override
  void dispose() {
    clearAll();
  }

  @override
  T get<T extends Object>() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  T getNamed<T extends Object>(String name) {
    // TODO: implement getNamed
    throw UnimplementedError();
  }

  @override
  void overrideInstance<T extends Object>(T instance) {
    // TODO: implement overrideInstance
  }

  @override
  void register<T extends Object>(T instance) {
    // TODO: implement register
  }

  @override
  void registerAsync<T extends Object>(Future<T> Function() asyncFactory) {
    // TODO: implement registerAsync
  }

  @override
  void registerConditional<T extends Object>(T Function() factory, bool Function() condition) {
    // TODO: implement registerConditional
  }

  @override
  void registerConditionalAsync<T extends Object>(Future<T> Function() asyncFactory, bool Function() condition) {
    // TODO: implement registerConditionalAsync
  }

  @override
  void registerFactory<T extends Object>(T Function() factory) {
    // TODO: implement registerFactory
  }

  @override
  void registerFactoryAsync<T extends Object>(Future<T> Function() asyncFactory) {
    // TODO: implement registerFactoryAsync
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() factory) {
    // TODO: implement registerLazySingleton
  }

  @override
  void registerLazySingletonAsync<T extends Object>(Future<T> Function() asyncFactory) {
    // TODO: implement registerLazySingletonAsync
  }

  @override
  void registerNamed<T extends Object>(String name, T instance) {
    // TODO: implement registerNamed
  }

  @override
  void registerNamedAsync<T extends Object>(String name, Future<T> Function() asyncFactory) {
    // TODO: implement registerNamedAsync
  }

  @override
  void registerSingleton<T extends Object>(T instance) {
    // TODO: implement registerSingleton
  }

  @override
  void registerSingletonAsync<T extends Object>(Future<T> Function() asyncFactory) {
    // TODO: implement registerSingletonAsync
  }

  @override
  void unregister<T extends Object>() {
    // TODO: implement unregister
  }

  @override
  void unregisterNamed<T extends Object>(String name) {
    // TODO: implement unregisterNamed
  }
}
