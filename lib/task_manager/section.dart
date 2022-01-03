import 'package:af_planner/shared/widgets/list_item.dart';
import 'package:af_planner/task_manager/models/section_model.dart';
import 'package:af_planner/task_manager/models/task_model.dart';
import 'package:af_planner/task_manager/task.dart';
import 'package:get_it_hooks/get_it_hooks.dart';
import 'package:flutter/material.dart';

class Section extends HookWidget {
  Section({Key? key, required this.section}) : super(key: key);

  SectionModel section;

  @override
  Widget build(BuildContext context) {
    final sectionListener = useListenable(section);
    final children = [
      for (final child in sectionListener.tasks)
        Task(
          task: child,
        )
    ];

    return section.isDefault
        ? ListItem(
            children: children,
            collapsable: false,
          )
        : ListItem(
            divider: true,
            content: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 8),
              child: Text(sectionListener.name),
            ),
            children: children,
            collapsable: sectionListener.tasks.isNotEmpty,
          );
  }
}
