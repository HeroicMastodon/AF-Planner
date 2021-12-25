
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

import 'models/task_model.dart';
import 'task_manager_service.dart';

class Task extends HookWidget {
  const Task({Key? key, required this.task, required this.index}) : super(key: key);

  final TaskModel task;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final service = useGet<TaskManagerService>();
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: theme.dividerColor))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: task.isComplete,
                onChanged: (value) {
                  task.isComplete = value ?? false;
                  service.updateTask(task, index);
                },
                shape: const CircleBorder(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(task.name),
                      if (task.description.isNotEmpty)
                        Text(task.description, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.w100),)
                      // for (var subtask in task.children) TaskListItemWidget(task: subtask),
                      // TaskListWidget(tasks: task.children, isChild: true)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
