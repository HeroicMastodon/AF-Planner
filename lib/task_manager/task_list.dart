import 'package:af_planner/task_manager/models/task_model.dart';
import 'package:af_planner/task_manager/task_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

import 'task.dart';

class TaskList extends HookWidget {
  const TaskList({Key? key, required this.tasks, this.isChild = false})
      : super(key: key);

  final List<TaskModel> tasks;
  final bool isChild;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: tasks.length,
      shrinkWrap: isChild,
    );
  }

  Widget itemBuilder(context, index) {
    return Task(task: tasks[index], index: index,);
  }
}
