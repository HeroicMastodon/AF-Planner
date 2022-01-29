import 'package:af_planner/task_manager/quick_add_form.dart';
import 'package:af_planner/task_manager/task_form.dart';
import 'package:flutter/material.dart';
import 'package:get_it_hooks/get_it_hooks.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ActionDialog extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ActionDialogItem(
            onTap: () {
              Navigator.of(context).pop();
              showQuickAdd(
                  context: context, onQuickAdd: (name, description) {});
            },
            icon: Icons.add_circle_outline,
            label: "Quick Add",
          ),
          const Divider(
            thickness: 1,
          ),
          ActionDialogItem(
              onTap: () {
                Navigator.of(context).pop();
                showTaskForm(context: context, onSave: (task) {});
              },
              label: "Add Task",
              icon: Icons.add_task),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

typedef OnTap = void Function();

class ActionDialogItem extends StatelessWidget {
  const ActionDialogItem({
    Key? key,
    required this.onTap,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final OnTap onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(label),
          )
        ],
      ),
    );
  }
}

showActionDialog(BuildContext context) {
  showCustomModalBottomSheet(
      context: context,
      builder: (context) => ActionDialog(),
      containerWidget: (context, animation, child) {
        return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(15),
                  child: child,
              ),
            )
          );
        }
    );
}
