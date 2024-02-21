import 'package:example/events/event_one.dart';
import 'package:example/services/service_one.dart';
import 'package:get/get.dart';
import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

class EventOneHandlerOne implements DomainEventHandler<EventOne> {
  final ServiceOne _serviceOne;

  EventOneHandlerOne(this._serviceOne);

  @override
  Future<void> handle(EventOne event) async {
    Get.snackbar(
      'Event received',
      'EventOne handled with handler 1',
      snackPosition: SnackPosition.BOTTOM,
    );

    _serviceOne.doSomething();
  }
}
