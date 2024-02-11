import 'package:zef_di_abstractions/zef_di_abstractions.dart';
import 'package:zef_di_inglue/zef_di_inglue.dart';
import 'package:test/test.dart';

import 'test_classes/test_impl_one.dart';
import 'test_classes/test_interface_one.dart';

void main() {
  group('Basic registrations', () {
    late InglueServiceLocatorAdapter adapter;

    setUp(() {
      // Construct the ServiceLocator
      adapter = InglueServiceLocatorAdapter();
      ServiceLocator.I.setAdapter(adapter);
    });

    test('Register a Singleton', () {
      final instance = TestImplOne();

      adapter.register(
        instance,
        interfaces: null,
        name: null,
        key: null,
        environment: null,
      );

      expect(adapter, isNot(throwsA(isA<Exception>())));
      expect(adapter.registrations, isNot(isNull));
      expect(adapter.registrations[TestImplOne], isNot(isNull));
      expect(adapter.registrations[TestImplOne]!.length, 1);
    });

    test('Register a Singleton with Interface', () {
      final instance = TestImplOne();

      adapter.register(
        instance,
        interfaces: [TestInterfaceOne],
        name: null,
        key: null,
        environment: null,
      );

      expect(adapter, isNot(throwsA(isA<Exception>())));
      expect(adapter.registrations, isNot(isNull));
      expect(adapter.registrations[TestImplOne], isNot(isNull));
      expect(adapter.registrations[TestImplOne]!.length, 1);
      expect(adapter.registrations[TestImplOne]!.first.interfaces, contains(TestInterfaceOne));
    });

    test('Register multiple Singletons', () {
      final instanceOne = TestImplOne();
      final instanceTwo = TestImplOne();

      adapter.register(
        instanceOne,
        interfaces: null,
        name: null,
        key: null,
        environment: null,
      );

      adapter.register(
        instanceTwo,
        interfaces: null,
        name: null,
        key: null,
        environment: null,
      );

      expect(adapter, isNot(throwsA(isA<Exception>())));
      expect(adapter.registrations, isNot(isNull));
      expect(adapter.registrations[TestImplOne], isNot(isNull));
      expect(adapter.registrations[TestImplOne]!.length, 2);
    });
  });
}
