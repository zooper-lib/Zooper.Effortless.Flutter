import 'package:test/test.dart';
import 'package:zef_di_abstractions/zef_di_abstractions.dart';
import 'package:zef_di_inglue/zef_di_inglue.dart';

import 'test_classes/interfaces/index.dart';
import 'test_classes/implementations/index.dart';

void main() {
  group('Adapter Singleton registrations', () {
    late InglueServiceLocatorAdapter adapter;

    setUp(() {
      // Construct the ServiceLocator
      adapter = InglueServiceLocatorAdapter();
      ServiceLocator.I.setAdapter(adapter);
    });

    test('No registratin found', () {
      expect(adapter, isNot(throwsA(isA<Exception>)));
      expect(adapter.registrations, isNot(isNull));
      expect(adapter.registrations.entries, isEmpty);
    });

    test('Register a Singleton', () {
      final instance = Eagle();

      adapter.register(
        instance,
        interfaces: null,
        name: null,
        key: null,
        environment: null,
      );

      expect(adapter, isNot(throwsA(isA<Exception>())));
      expect(adapter.registrations, isNot(isNull));
      expect(adapter.registrations[Eagle], isNot(isNull));
      expect(adapter.registrations[Eagle]!.length, 1);
    });

    test('Register a Singleton with Interface', () {
      final instance = Eagle();

      adapter.register(
        instance,
        interfaces: [Bird, Animal],
        name: null,
        key: null,
        environment: null,
      );

      expect(adapter, isNot(throwsA(isA<Exception>())));
      expect(adapter.registrations, isNot(isNull));
      expect(adapter.registrations[Eagle], isNot(isNull));
      expect(adapter.registrations[Eagle]!.length, 1);
      expect(adapter.registrations[Eagle]!.first.interfaces, contains(Bird));
      expect(adapter.registrations[Eagle]!.first.interfaces, contains(Animal));
    });

    test('Register same Singletons multiple times', () {
      final dolphin1 = Dolphin();
      final dolphin2 = Dolphin();

      adapter.register(
        dolphin1,
        interfaces: [Fish, Animal],
        name: null,
        key: null,
        environment: null,
      );

      adapter.register(
        dolphin2,
        interfaces: [Fish, Animal],
        name: null,
        key: null,
        environment: null,
      );

      expect(adapter, isNot(throwsA(isA<Exception>())));
      expect(adapter.registrations, isNot(isNull));
      expect(adapter.registrations[Dolphin], isNot(isNull));
      expect(adapter.registrations[Dolphin]!.length, 2);
    });

    test('Register multiple Singletons', () {
      final dolphin = Dolphin();
      final shark = Shark();
      final whale = Whale();

      adapter.register(
        dolphin,
        interfaces: [Fish, Animal],
        name: null,
        key: null,
        environment: null,
      );

      adapter.register(
        shark,
        interfaces: [Fish, Animal],
        name: null,
        key: null,
        environment: null,
      );

      adapter.register(
        whale,
        interfaces: [Fish, Animal],
        name: null,
        key: null,
        environment: null,
      );

      expect(adapter, isNot(throwsA(isA<Exception>())));
      expect(adapter.registrations, isNot(isNull));
      expect(adapter.registrations[Dolphin], isNot(isNull));
      expect(adapter.registrations[Dolphin]!.length, 1);
      expect(adapter.registrations[Shark], isNot(isNull));
      expect(adapter.registrations[Shark]!.length, 1);
      expect(adapter.registrations[Whale], isNot(isNull));
      expect(adapter.registrations[Whale]!.length, 1);

      expect(adapter.registrations[Dolphin]!.first.interfaces, contains(Fish));
      expect(adapter.registrations[Dolphin]!.first.interfaces, contains(Animal));
      expect(adapter.registrations[Shark]!.first.interfaces, contains(Fish));
      expect(adapter.registrations[Shark]!.first.interfaces, contains(Animal));
      expect(adapter.registrations[Whale]!.first.interfaces, contains(Fish));
      expect(adapter.registrations[Whale]!.first.interfaces, contains(Animal));
    });

    test('Register named Singletons', () {
      final dolphin = Dolphin();
      final shark = Shark();
      final whale = Whale();

      adapter.register(
        dolphin,
        interfaces: [Fish, Animal],
        name: 'dolphin',
        key: null,
        environment: null,
      );

      adapter.register(
        shark,
        interfaces: [Fish, Animal],
        name: 'shark',
        key: null,
        environment: null,
      );

      adapter.register(
        whale,
        interfaces: [Fish, Animal],
        name: 'whale',
        key: null,
        environment: null,
      );

      expect(adapter, isNot(throwsA(isA<Exception>())));
      expect(adapter.registrations, isNot(isNull));
      expect(adapter.registrations[Dolphin], isNot(isNull));
      expect(adapter.registrations[Dolphin]!.length, 1);
      expect(adapter.registrations[Shark], isNot(isNull));
      expect(adapter.registrations[Shark]!.length, 1);
      expect(adapter.registrations[Whale], isNot(isNull));
      expect(adapter.registrations[Whale]!.length, 1);

      expect(adapter.registrations[Dolphin]!.first.name, 'dolphin');
      expect(adapter.registrations[Shark]!.first.name, 'shark');
      expect(adapter.registrations[Whale]!.first.name, 'whale');
    });

    test('Register named Singletons with same name', () {
      final dolphin1 = Dolphin();
      final dolphin2 = Dolphin();

      adapter.register(
        dolphin1,
        interfaces: [Fish, Animal],
        name: 'dolphin',
        key: null,
        environment: null,
      );

      adapter.register(
        dolphin2,
        interfaces: [Fish, Animal],
        name: 'dolphin',
        key: null,
        environment: null,
      );

      expect(adapter, isNot(throwsA(isA<Exception>())));
      expect(adapter.registrations, isNot(isNull));
      expect(adapter.registrations[Dolphin], isNot(isNull));
      expect(adapter.registrations[Dolphin]!.length, 1);
    });
  });
}
