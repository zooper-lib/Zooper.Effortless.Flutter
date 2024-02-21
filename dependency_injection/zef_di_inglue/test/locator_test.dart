import 'package:test/test.dart';
import 'package:zef_di_abstractions/zef_di_abstractions.dart';

import 'setup.dart';

void main() {
  group('ServiceLocator Initialization Tests', () {
    test('Should throw StateError', () {
      expect(() => ServiceLocator.I, throwsA(isA<StateError>()));
    });

    test('Should return an instance of ServiceLocator', () {
      initializeServiceLocator();

      final instance = ServiceLocator.I;
      expect(instance, isA<ServiceLocator>());
    });
  });
}
