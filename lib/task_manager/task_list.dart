import 'package:af_planner/task_manager/models/section_model.dart';
import 'package:af_planner/task_manager/models/task_list_model.dart';
import 'package:af_planner/task_manager/models/task_model.dart';
import 'package:af_planner/task_manager/section.dart';
import 'package:af_planner/task_manager/task_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

import 'task.dart';

class TaskList extends HookWidget {
  const TaskList({Key? key, required this.model})
      : super(key: key);

  final TaskListModel model;

  @override
  Widget build(BuildContext context) {
    final modelListener = useListenable(model);
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: model.sections.length + model.unassignedTasks.length,
    );
  }

  Widget itemBuilder(context, index) {
    if (index < model.unassignedTasks.length) {
      return Task(task: model.unassignedTasks[index],);
    }
    return Section(section: model.sections[index - model.unassignedTasks.length]);
  }
}
