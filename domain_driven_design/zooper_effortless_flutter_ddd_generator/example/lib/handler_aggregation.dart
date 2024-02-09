import 'package:example/events/event_one.dart';
import 'package:example/events/event_two.dart';
import 'package:example/handlers/event_one_handler.dart';
import 'package:example/handlers/event_two_handler.dart';
import 'package:zooper_effortless_flutter_ddd_generator/zooper_effortless_flutter_ddd_generator.dart';
import 'package:get_it/get_it.dart';
import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

part 'handler_aggregation.g.dart';

@HandlerAggregate()
void triggerCodeGeneration() {}
