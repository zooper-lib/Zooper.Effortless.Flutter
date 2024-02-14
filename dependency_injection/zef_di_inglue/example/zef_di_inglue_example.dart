import 'package:zef_di_abstractions/zef_di_abstractions.dart';
import 'package:zef_di_inglue/zef_di_inglue.dart';

import 'test_classes/implementations/index.dart';
import 'test_classes/interfaces/index.dart';

void main() {
  // Build the ServiceLocator
  ServiceLocatorBuilder().withAdapter(InglueServiceLocatorAdapter()).build();

  // Register the Singleton
  ServiceLocator.I.registerInstance(
    Dolphin(),
    interfaces: [Animal, Fish],
    name: 'Dolphin',
  );

  ServiceLocator.I.registerInstance(
    Dolphin(),
    interfaces: [Animal, Fish],
    name: 'Dolphin2',
  );

  // Retrieve the Singleton
  final instance = ServiceLocator.I.getFirst<Dolphin>(
    name: 'Dolphin',
  );

  // Do something with the instance
  print(instance.runtimeType); // Output: Dolphin
}
