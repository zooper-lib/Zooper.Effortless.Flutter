import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

class EventOne extends DomainEvent {
  final String message;
  final int number;

  EventOne(this.message, this.number);
}
