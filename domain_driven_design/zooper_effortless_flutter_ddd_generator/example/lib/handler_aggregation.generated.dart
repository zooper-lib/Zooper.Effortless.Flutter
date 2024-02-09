// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DomainEventHandlerGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'path/to/domain_event_handler.dart';
import 'package:get_it/get_it.dart';
import 'path/to/domain_event_handler.dart';
import 'package:get_it/get_it.dart';
import 'path/to/domain_event_handler.dart';
import 'package:get_it/get_it.dart';
import 'path/to/domain_event_handler.dart';
import 'package:get_it/get_it.dart';
import 'path/to/domain_event_handler.dart';
import 'package:get_it/get_it.dart';
import 'path/to/domain_event_handler.dart';
import 'package:get_it/get_it.dart';
import 'path/to/domain_event_handler.dart';
import 'package:example/example/handlers/event_two_handler.dart';
import 'package:example/example/handlers/event_two_handler.dart';
import 'package:example/example/handlers/event_one_handler.dart';
import 'package:example/example/handlers/event_two_handler.dart';
import 'package:example/example/handlers/event_one_handler.dart';
import 'package:example/example/handlers/event_two_handler.dart';
import 'package:example/example/handlers/event_one_handler.dart';

void registerGeneratedHandlers() {
  GetIt.I.registerSingleton<DomainEventHandler<EventTwo>>(EventTwoHandler());
  GetIt.I.registerSingleton<DomainEventHandler<EventOne>>(EventOneHandler());
}
