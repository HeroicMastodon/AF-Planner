import 'package:af_planner/task_manager/task_list_widget.dart';
import 'package:af_planner/task_manager/task_manager_store.dart';
import 'package:af_planner/task_manager/task_manager_model.dart';
import 'package:af_planner/task_manager/task_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

class TaskManager extends HookWidget {
  const TaskManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = useGet<TaskManagerService>();
    final tasks = useWatchXOnly((TaskManagerStore store) => store.taskList, (TaskListModel taskList) => taskList.tasks);
    return TaskListWidget(tasks: tasks);
  }
}
