import 'package:example/events/event_two.dart';
import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

class EventTwoHandler implements DomainEventHandler<EventTwo> {
  @override
  Future<void> handle(EventTwo event) async {
    // ignore: avoid_print
    print('EventTwo handled: ${event.isTrue} ${event.pi}');
  }
}
