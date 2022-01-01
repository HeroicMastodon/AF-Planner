import 'package:af_planner/shared/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

import 'models/task_model.dart';
import 'task_manager_service.dart';

class Task extends HookWidget {
  const Task({Key? key, required this.task})
      : super(key: key);

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final service = useGet<TaskManagerService>();
    final watchedTask = useListenable(task);
    return ListItem(
        divider: true,
        onTap: () => print('tapped'),
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
            service.completeTask(task, value ?? false);
          },
          shape: const CircleBorder(),
        ),
        children: task.children.map((e) => Task(task: e)).toList()
        // [
        //   for (var i = 1; i < task.children.length; i++)
        //     Task(index: i, task: task.children[i])
        // ]
        );
  }
}
