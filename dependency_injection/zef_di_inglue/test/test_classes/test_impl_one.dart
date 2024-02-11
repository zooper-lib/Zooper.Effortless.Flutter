import 'test_interface_one.dart';

class TestImplOne implements TestInterfaceOne {
  String getValue() {
    return 'Hello, World!';
  }

  @override
  String testMethodOne() {
    return 'Hello, World from method';
  }
}
