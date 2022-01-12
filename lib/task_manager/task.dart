import 'package:af_planner/shared/widgets/list_item.dart';
import 'package:af_planner/task_manager/task_form.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

import 'models/task_model.dart';
import 'task_manager_service.dart';

typedef OnUncompleteCallback = void Function(List<TaskModel> tasks);

class Task extends HookWidget {
  const Task({Key? key, required this.task, this.onUncomplete})
      : super(key: key);

  final TaskModel task;
  final OnUncompleteCallback? onUncomplete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final service = useGet<TaskManagerService>();
    final watchedTask = useListenable(task);
    return ListItem(
        divider: true,
        onTap: () =>
            showTaskForm(
                context: context,
                model: watchedTask,
                onSave: (TaskModel updatedTask) {
                  watchedTask.copyFrom(updatedTask);
                },
              ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.name),
              task.description.isNotEmpty
                  ? Text(task.description)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        left: Checkbox(
          value: task.isComplete,
          visualDensity: VisualDensity.compact,
          splashRadius: 16,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) {
            // task.isComplete = value ?? false;
            if (value == true) {
              service.completeTask(task);
            } else {
              service.uncompleteTask(task);
            }
          },
          shape: const CircleBorder(),
        ),
        children: task.children
            .map((e) => Task(
                  task: e,
                ))
            .toList());
  }
}
