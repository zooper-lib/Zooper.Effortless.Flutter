import 'package:zooper_effortless_flutter_di/src/interfaces/service_locator.dart';
import 'package:zooper_effortless_flutter_di/src/interfaces/service_locator_adapter.dart';

class ServiceLocatorBuilder {
  ServiceLocatorBuilder setAdapter(ServiceLocatorAdapter adapter) {
    ServiceLocator.instance.setAdapter(adapter);
    return this;
  }

  ServiceLocatorBuilder register<T extends Object>(T instance) {
    ServiceLocator.instance.register<T>(instance);
    return this;
  }

  ServiceLocatorBuilder registerAsync<T extends Object>(Future<T> Function() asyncFactory) {
    ServiceLocator.instance.registerAsync<T>(asyncFactory);
    return this;
  }

  ServiceLocatorBuilder registerSingleton<T extends Object>(T instance) {
    ServiceLocator.instance.registerSingleton<T>(instance);
    return this;
  }

  ServiceLocatorBuilder registerSingletonAsync<T extends Object>(Future<T> Function() asyncFactory) {
    ServiceLocator.instance.registerSingletonAsync<T>(asyncFactory);
    return this;
  }

  ServiceLocatorBuilder registerFactory<T extends Object>(T Function() factory) {
    ServiceLocator.instance.registerFactory<T>(factory);
    return this;
  }

  ServiceLocatorBuilder registerFactoryAsync<T extends Object>(Future<T> Function() asyncFactory) {
    ServiceLocator.instance.registerFactoryAsync<T>(asyncFactory);
    return this;
  }

  ServiceLocatorBuilder registerLazySingleton<T extends Object>(T Function() factory) {
    ServiceLocator.instance.registerLazySingleton<T>(factory);
    return this;
  }

  ServiceLocatorBuilder registerLazySingletonAsync<T extends Object>(Future<T> Function() asyncFactory) {
    ServiceLocator.instance.registerLazySingletonAsync<T>(asyncFactory);
    return this;
  }

  ServiceLocatorBuilder unregister<T extends Object>() {
    ServiceLocator.instance.unregister<T>();
    return this;
  }

  ServiceLocatorBuilder clearAll() {
    ServiceLocator.instance.clearAll();
    return this;
  }

  ServiceLocatorBuilder dispose() {
    ServiceLocator.instance.dispose();
    return this;
  }
}
