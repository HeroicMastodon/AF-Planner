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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                      icon: const Icon(Icons.arrow_back),
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                    ),
                    IconButton(
                      onPressed: () {
                        shouldClose.value = true;
                        onSave(newTask.value);
                        Navigator.of(context).maybePop();
                      },
                      icon: const Icon(Icons.save),
                      splashRadius: 20,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      Text("Start Date"),
                      Text("Due Date"),
                      Text("Repeat"),
                      Text("Priority"),
                      Text("Location"),
                      Text("Subtasks"),
                      Text("Reminders"),
                      Text("attachments"),
                      Text("Calendars"),
                      Text("Timer")
                    ],
                  ),
                ),
              ],
            ),
          ),
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
    expand: true,
    duration: const Duration(milliseconds: 300),
    // shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
  );
}
