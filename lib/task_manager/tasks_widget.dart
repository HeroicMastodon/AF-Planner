import 'package:af_planner/task_manager/task_list_widget.dart';
import 'package:af_planner/task_manager/tasks_model.dart';
import 'package:af_planner/task_manager/tasks_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

class TasksWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final service = useGet<TasksService>();
    final tasks = useWatchOnly((TaskListModel model) => model.tasks);
    return TaskListWidget(tasks: tasks);
  }
}
