import 'package:af_planner/task_manager/models/task_model.dart';
import 'package:af_planner/task_manager/task_manager.dart';
import 'package:af_planner/task_manager/task_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final service = useGet<TaskManagerService>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(color: Colors.blue),
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Planner"),
        ),
        body: TaskManager(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => service.addTask(TaskModel(), null),
        ),
      ),
    );
  }
}
