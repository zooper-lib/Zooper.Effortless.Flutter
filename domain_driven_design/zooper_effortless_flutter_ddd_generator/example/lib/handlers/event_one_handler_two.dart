import 'package:example/events/event_one.dart';
import 'package:get/get.dart';
import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

class EventOneHandlerTwo implements DomainEventHandler<EventOne> {
  @override
  Future<void> handle(EventOne event) async {
    Get.snackbar(
      'Event received',
      'EventOne handled with handler 2',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
