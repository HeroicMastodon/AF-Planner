import 'package:af_planner/task_manager/models/task_model.dart';
import 'package:af_planner/task_manager/task_form.dart';
import 'package:af_planner/task_manager/task_manager.dart';
import 'package:af_planner/task_manager/task_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it_hooks/get_it_hooks.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final service = useGet<TaskManagerService>();
    final theme = ThemeData(
      primarySwatch: Colors.blue,
      appBarTheme: AppBarTheme(color: Colors.blue),
      brightness: Brightness.dark,
      backgroundColor: Colors.white10,
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white10,
          brightness: Brightness.dark),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: Builder(
          builder: (context) => SafeArea(
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    title: const Text("Planner"),
                  ),
                  body: TaskManager(),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endDocked,
                  floatingActionButton: Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom < 90,
                    child: SpeedDial(
                      icon: Icons.add,
                      activeIcon: Icons.close,
                      backgroundColor: theme.colorScheme.primary,
                      activeBackgroundColor: theme.backgroundColor,
                      foregroundColor: theme.colorScheme.onPrimary,
                      activeForegroundColor: theme.colorScheme.onBackground,
                      children: [
                        SpeedDialChild(
                            child: Icon(Icons.add_task,
                                color: theme.colorScheme.primary),
                            onTap: () {
                              showTaskForm(context: context, isQuick: true, onSave: saveNewTask(service));
                            },
                            onLongPress: () {
                              showTaskForm(context: context, onSave: saveNewTask(service));
                            })
                      ],
                    ),
                  ),
                  bottomNavigationBar: BottomAppBar(
                    shape: const CircularNotchedRectangle(),
                    color: theme.colorScheme.primary,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.checklist_outlined))
                      ],
                    ),
                  ),
                ),
              )),
    );
  }

  saveNewTask(TaskManagerService service) => (TaskModel newTask) {
    service.addTask(newTask, null);
  };
}
