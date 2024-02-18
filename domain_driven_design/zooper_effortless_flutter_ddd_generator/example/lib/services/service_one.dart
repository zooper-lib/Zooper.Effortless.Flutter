import 'package:get/get.dart';

class ServiceOne {
  void doSomething() {
    Get.snackbar(
      'Service One',
      'Service One did something!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
