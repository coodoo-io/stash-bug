// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_hive/stash_hive.dart';
import 'package:stash_test/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  store() async {
    // Temporary directory
    final path = Directory.systemTemp.path;

    // Creates a store
    final store = await newHiveDefaultVaultStore(path: path);

    // Creates a vault from the previously created store
    final vault = await store.vault<Task>(
        name: 'vault', fromEncodable: (json) => Task.fromJson(json), eventListenerMode: EventListenerMode.synchronous)
      ..on<VaultEntryCreatedEvent<Task>>().listen((event) => print('Key "${event.entry.key}" added to the vault'));

    // Adds a task with key 'task1' to the vault
    await vault.put('task1', Task(id: 1, title: 'Run vault store example', completed: true));
    // Retrieves the value from the vault
    print(await vault.get('task1'));
  }

  retrieve() async {
    // Temporary directory
    final path = Directory.systemTemp.path;

    // Creates a store
    final store = await newHiveDefaultVaultStore(path: path);

    // Creates a vault from the previously created store
    final vault = await store.vault<Task>(
        name: 'vault', fromEncodable: (json) => Task.fromJson(json), eventListenerMode: EventListenerMode.synchronous)
      ..on<VaultEntryCreatedEvent<Task>>().listen((event) => print('Key "${event.entry.key}" added to the vault'));

    // Retrieves the value from the vault
    print(await vault.get('task1'));
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
            OutlinedButton(onPressed: () => store(), child: const Text('Store')),
            OutlinedButton(onPressed: () => retrieve(), child: const Text('Retrieve')),
          ],
        ),
      ),
    );
  }
}
