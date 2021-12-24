import 'package:af_planner/task_manager/task_manager_model.dart';
import 'package:af_planner/task_manager/task_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';

class TaskListWidget extends HookWidget {
  const TaskListWidget({Key? key, required this.tasks, this.isChild = false})
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
    return TaskListItemWidget(task: tasks[index], index: index,);
  }
}

class TaskListItemWidget extends HookWidget {
  const TaskListItemWidget({Key? key, required this.task, required this.index}) : super(key: key);

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
