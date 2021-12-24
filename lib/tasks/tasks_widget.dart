import 'package:af_planner/tasks/task_list_widget.dart';
import 'package:af_planner/tasks/tasks_model.dart';
import 'package:af_planner/tasks/tasks_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

class TasksWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final service = useGet<TasksService>();
    final tasks = useWatchOnly((TaskListModel model) => model);
    return TaskListWidget(tasks: tasks.tasks);
  }
}
