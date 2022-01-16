import 'package:af_planner/task_manager/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:popover/popover.dart';

typedef OnSave = void Function(TaskModel updatedTask);

class TaskForm extends HookWidget {
  const TaskForm(
      {Key? key,
      required this.task,
      required this.onSave})
      : super(key: key);
  final TaskModel task;
  final OnSave onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var shouldClose = useState(/*task.id == ""*/true);
    var newTask = useState(task.clone(includeId: true));

    return WillPopScope(
      onWillPop: () async {
        if (!shouldClose.value) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text("Really?"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          shouldClose.value = true;
                        },
                        child: Text("Close"))
                  ],
                ));
        }
        return shouldClose.value;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    autocorrect: true,
                    initialValue: newTask.value.name,
                    onChanged: (value) {
                      newTask.value.name = value;
                      shouldClose.value = false;
                    },
                    decoration: const InputDecoration(
                      hintText: "Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    shouldClose.value = true;
                    onSave(newTask.value);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.save),
                  splashRadius: 20,
                ),
              ],
            ),
            TextFormField(
              initialValue: newTask.value.description,
              onChanged: (value) {
                newTask.value.description = value;
                shouldClose.value = true;
              },
              decoration: const InputDecoration(
                  hintText: "Description", border: InputBorder.none),
              style: const TextStyle(fontWeight: FontWeight.w200),
              minLines: 2,
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}

showTaskForm(
    {required BuildContext context,
    TaskModel? model,
    bool isQuick = false,
    required OnSave onSave}) {
  showMaterialModalBottomSheet(
    context: context,
    builder: (context) => TaskForm(
      task: model ?? TaskModel(),
      onSave: onSave,
    ),
    expand: false,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
  );
}
