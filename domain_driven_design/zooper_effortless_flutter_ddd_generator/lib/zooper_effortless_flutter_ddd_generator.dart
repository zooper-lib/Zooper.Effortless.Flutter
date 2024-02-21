library zooper_effortless_flutter_ddd_generator;

export 'src/annotations/index.dart';
export 'src/generators/index.dart';
export 'src/helpers/index.dart';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:zooper_effortless_flutter_ddd_generator/zooper_effortless_flutter_ddd_generator.dart';

Builder handlerGeneratorBuilder(BuilderOptions options) =>
    LibraryBuilder(DomainEventHandlerGenerator(), generatedExtension: '.generated.dart');
