import 'package:example/events/event_two.dart';
import 'package:get/get.dart';
import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

class EventTwoHandler implements DomainEventHandler<EventTwo> {
  @override
  Future<void> handle(EventTwo event) async {
    Get.snackbar(
      'Event received',
      'EventTwo handled',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
