import 'package:zef_di_abstractions/src/helpers/log_helper.dart';
import 'package:zef_di_abstractions/src/helpers/user_messages.dart';
import 'package:zef_di_abstractions/zef_di_abstractions.dart';

class ServiceLocator {
  static ServiceLocator? _instance;

  final ServiceLocatorAdapter _adapter;
  final ServiceLocatorConfig _config;

  // Private constructor
  ServiceLocator._internal({
    required ServiceLocatorAdapter adapter,
    ServiceLocatorConfig? config,
  })  : _adapter = adapter,
        _config = config ?? const ServiceLocatorConfig();

  /// Static method to access the instance
  static ServiceLocator get instance {
    if (_instance == null) {
      throw StateError(
          '$ServiceLocator must be initialized using the $ServiceLocatorBuilder before accessing the instance.');
    }
    return _instance!;
  }

  /// Static method to access the instance in a short way
  static ServiceLocator get I => instance;

  /// Registers an instance of type [T].
  void registerInstance<T extends Object>(
    T instance, {
    List<Type>? interfaces,
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.registerInstance<T>(
      instance,
      interfaces: interfaces,
      name: name,
      key: key,
      environment: environment,
    );

    // On conflict
    if (response.isSecond) {
      LogHelper.log(
        registrationAlreadyExistsForType(T),
        level: LogLevel.warning,
        minimumLogLevel: _config.minimumLogLevel,
      );
    }

    // On internal error
    if (response.isThird) {
      LogHelper.log(
        internalErrorOccurred(response.third.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.third.message);
    }
  }

  /// Registers a factory for type [T].
  void registerFactory<T extends Object>(
    T Function(ServiceLocator serviceLocator) factory, {
    List<Type>? interfaces,
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.registerFactory<T>(
      factory,
      interfaces: interfaces,
      name: name,
      key: key,
      environment: environment,
    );

    // On conflict
    if (response.isSecond && _config.minimumLogLevel <= LogLevel.warning) {
      LogHelper.log(
        registrationAlreadyExistsForType(T),
        level: LogLevel.warning,
        minimumLogLevel: _config.minimumLogLevel,
      );
    }

    // On internal error
    if (response.isThird) {
      LogHelper.log(
        internalErrorOccurred(response.third.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.third.message);
    }
  }

  /// Retrieves an instance of type [T].
  T? getFirst<T extends Object>({
    Type? interface,
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.getFirst<T>(
      name: name,
      key: key,
      environment: environment,
    );

    // On not found
    if (response.isSecond && _config.minimumLogLevel <= LogLevel.warning) {
      LogHelper.log(
        registrationAlreadyExistsForType(T),
        level: LogLevel.warning,
        minimumLogLevel: _config.minimumLogLevel,
      );

      return null;
    }

    // On internal error
    if (response.isThird) {
      LogHelper.log(
        internalErrorOccurred(response.third.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.third.message);
    }

    return response.first;
  }

  /// Retrieves a List of instances of type [T].
  List<T> getAll<T extends Object>({
    Type? interface,
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.getAll<T>(
      name: name,
      key: key,
      environment: environment,
    );

    // On not found
    if (response.isSecond) {
      LogHelper.log(
        registrationAlreadyExistsForType(T),
        level: LogLevel.warning,
        minimumLogLevel: _config.minimumLogLevel,
      );
      return [];
    }

    // On internal error
    if (response.isThird) {
      LogHelper.log(
        internalErrorOccurred(response.third.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.third.message);
    }

    return response.first;
  }

  /// Overrides an existing registration with a new instance of type [T].
  void overrideInstance<T extends Object>(
    T instance, {
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.overrideInstance<T>(
      instance,
      name: name,
      key: key,
      environment: environment,
    );

    // On internal error
    if (response.isSecond) {
      LogHelper.log(
        internalErrorOccurred(response.second.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.second.message);
    }
  }

  /// Overrides an existing registration with a new factory of type [T].
  void overrideFactory<T extends Object>(
    T Function(ServiceLocator serviceLocator) factory, {
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.overrideFactory<T>(
      factory,
      name: name,
      key: key,
      environment: environment,
    );

    // On internal error
    if (response.isSecond) {
      LogHelper.log(
        internalErrorOccurred(response.second.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.second.message);
    }
  }

  /// Unregisters an instance of type [T].
  void unregister<T extends Object>({
    String? name,
    dynamic key,
    String? environment,
  }) {
    final response = _adapter.unregister<T>(
      name: name,
      key: key,
      environment: environment,
    );

    // On not found
    if (response.isSecond && _config.minimumLogLevel <= LogLevel.warning) {
      LogHelper.log(
        registrationAlreadyExistsForType(T),
        level: LogLevel.warning,
        minimumLogLevel: _config.minimumLogLevel,
      );
    }

    // On internal error
    if (response.isThird) {
      LogHelper.log(
        internalErrorOccurred(response.third.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.third.message);
    }
  }

  /// Unregisters all instances
  void unregisterAll() {
    final response = _adapter.unregisterAll();

    // On internal error
    if (response.isSecond) {
      LogHelper.log(
        internalErrorOccurred(response.second.message),
        level: LogLevel.error,
        minimumLogLevel: _config.minimumLogLevel,
      );
      throw StateError(response.second.message);
    }
  }
}

class ServiceLocatorBuilder {
  ServiceLocatorAdapter? _adapter;
  ServiceLocatorConfig? _config;

  /// Sets the adapter for the [ServiceLocator].
  ServiceLocatorBuilder withAdapter(ServiceLocatorAdapter adapter) {
    _adapter = adapter;
    return this;
  }

  /// Sets the config for the [ServiceLocator].
  ServiceLocatorBuilder withConfig(ServiceLocatorConfig config) {
    _config = config;
    return this;
  }

  /// Builds the [ServiceLocator].
  void build() {
    if (ServiceLocator._instance != null) {
      throw StateError('$ServiceLocator has already been initialized.');
    }

    if (_adapter == null) {
      throw StateError('$ServiceLocatorAdapter must be set before building the $ServiceLocator.');
    }

    ServiceLocator._instance = ServiceLocator._internal(adapter: _adapter!, config: _config);
  }
}
