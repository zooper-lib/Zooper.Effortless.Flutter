import 'package:test/test.dart';
import 'package:zef_di_abstractions/zef_di_abstractions.dart';
import 'package:zef_di_inglue/zef_di_inglue.dart';

void main() {
  group('ServiceLocator Initialization Tests', () {
    test('Should return an instance of ServiceLocator', () {
      final instance = ServiceLocator.I;
      expect(instance, isA<ServiceLocator>());
    });

    test('Should throw StateError', () {
      expect(() => ServiceLocator.I.adapter, throwsA(isA<StateError>()));
    });

    test('Should return an instance of ServiceLocator with a valid adapter', () {
      final adapter = InglueServiceLocatorAdapter();
      ServiceLocator.I.setAdapter(adapter);
      expect(ServiceLocator.I.adapter, isA<ServiceLocatorAdapter>());
    });
  });
}
