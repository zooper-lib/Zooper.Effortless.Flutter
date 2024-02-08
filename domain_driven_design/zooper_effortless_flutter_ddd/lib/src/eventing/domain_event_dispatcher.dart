import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

class DomainEventDispatcher {
  final Map<Type, List<DomainEventHandler<DomainEvent>>> _handlers = {};

  void registerHandler<T extends DomainEvent>(Type eventType, DomainEventHandler<T> handler) {
    _handlers[eventType] ??= [];
    _handlers[eventType]!.add(handler);
  }

  Future<void> dispatch(DomainEvent event) async {
    List<DomainEventHandler<DomainEvent>>? eventHandlers = _handlers[event.runtimeType];
    if (eventHandlers != null) {
      for (var handler in eventHandlers) {
        await handler.handle(event);
      }
    }
  }
}
