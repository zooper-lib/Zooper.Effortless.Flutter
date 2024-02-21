import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

abstract class DomainEventHandler<T extends DomainEvent> {
  Future<void> handle(T event);
}
