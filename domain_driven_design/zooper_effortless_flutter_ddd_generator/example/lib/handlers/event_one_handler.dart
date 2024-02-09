import 'package:example/events/event_one.dart';
import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

//@GenerateHandlerRegistration()
class EventOneHandler implements DomainEventHandler<EventOne> {
  @override
  Future<void> handle(EventOne event) async {
    // ignore: avoid_print
    print('EventOne handled: ${event.message} ${event.number}');
  }
}
