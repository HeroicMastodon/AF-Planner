import 'package:af_planner/task_manager/models/section_model.dart';
import 'package:af_planner/task_manager/models/task_model.dart';
import 'package:af_planner/task_manager/section.dart';
import 'package:af_planner/task_manager/task_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

import 'task.dart';

class TaskList extends HookWidget {
  const TaskList({Key? key, required this.sections})
      : super(key: key);

  final List<SectionModel> sections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: sections.length,
    );
  }

  Widget itemBuilder(context, index) {
    return Section(section: sections[index]);
  }
}
