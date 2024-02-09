// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DomainEventHandlerGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';
import 'package:example/handlers/event_one_handler.dart';
import 'package:example/events/event_one.dart';
import 'package:example/handlers/event_two_handler.dart';
import 'package:example/events/event_two.dart';

void registerGeneratedHandlers() {
  GetIt.I.registerSingleton<DomainEventHandler<EventOne>>(EventOneHandler());
  GetIt.I.registerSingleton<DomainEventHandler<EventTwo>>(EventTwoHandler());
}
