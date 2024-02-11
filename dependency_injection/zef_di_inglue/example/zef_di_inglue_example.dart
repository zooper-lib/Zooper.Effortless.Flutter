import 'package:zef_di_abstractions/zef_di_abstractions.dart';
import 'package:zef_di_inglue/zef_di_inglue.dart';

import 'test_classes/implementations/index.dart';
import 'test_classes/interfaces/index.dart';

void main() {
  // Register the Adapter with the ServiceLocator
  final adapter = InglueServiceLocatorAdapter();
  ServiceLocator.I.setAdapter(adapter);

  // Register the Singleton
  ServiceLocator.I.register(
    Dolphin(),
    interfaces: [Animal, Fish],
    name: 'Dolphin',
  );

  // Retrieve the Singleton
  final instance = ServiceLocator.I.getFirst<Dolphin>(
    name: 'Dolphin',
  );

  // Do something with the instance
  print(instance.runtimeType); // Output: Dolphin
}
