import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

class EventTwo extends DomainEvent {
  final bool isTrue;
  final double pi;

  EventTwo(this.isTrue, this.pi);
}
