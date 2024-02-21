import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

class DomainEventDispatcher {
  // Singleton instance, internally managed
  static final DomainEventDispatcher _instance = DomainEventDispatcher._internal();

  // Instance variable to hold handlers
  final Map<Type, List<DomainEventHandler<DomainEvent>>> _handlers = {};

  // Private constructor to prevent external instantiation
  DomainEventDispatcher._internal();

  // Public getter to access the singleton instance
  static DomainEventDispatcher get instance => _instance;

  // Method to register handlers
  void registerHandler<T extends DomainEvent>(DomainEventHandler<T> handler) {
    final Type eventType = T;

    _handlers[eventType] ??= [];
    _handlers[eventType]!.add(handler);
  }

  // Method to dispatch events
  Future<void> dispatch(DomainEvent event) async {
    List<DomainEventHandler<DomainEvent>>? eventHandlers = _handlers[event.runtimeType];
    if (eventHandlers != null) {
      for (var handler in eventHandlers) {
        await handler.handle(event);
      }
    }
  }
}
