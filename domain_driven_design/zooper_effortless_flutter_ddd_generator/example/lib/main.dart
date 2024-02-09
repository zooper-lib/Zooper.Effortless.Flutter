import 'package:example/events/index.dart';
import 'package:example/handler_aggregation.generated.dart';
import 'package:example/handlers/event_one_handler_one.dart';
import 'package:example/handlers/event_one_handler_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zooper_effortless_flutter_ddd/zooper_effortless_flutter_ddd.dart';

import 'handlers/event_two_handler.dart';

void main() {
  registerGeneratedHandlers();

  final domainEventDispatcher = DomainEventDispatcher.instance;
  domainEventDispatcher.registerHandler(EventOneHandlerOne());
  domainEventDispatcher.registerHandler(EventOneHandlerTwo());

  domainEventDispatcher.registerHandler(EventTwoHandler());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DomainEventDispatcher Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'DomainEventDispatcher Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() async {
    final domainEventDispatcher = DomainEventDispatcher.instance;
    await domainEventDispatcher.dispatch(EventOne());
    await domainEventDispatcher.dispatch(EventOne());

    await domainEventDispatcher.dispatch(EventTwo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Push the buttons to dispath events',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await DomainEventDispatcher.instance.dispatch(EventOne());
              },
              child: const Text('Event One'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await DomainEventDispatcher.instance.dispatch(EventTwo());
              },
              child: const Text('Event Two'),
            ),
          ],
        ),
      ),
    );
  }
}
