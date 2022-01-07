import 'package:af_planner/task_manager/models/section_model.dart';
import 'package:flutter/material.dart';

import 'task_model.dart';

class TaskListModel extends ChangeNotifier {
  List<SectionModel> _sections = [];

  List<SectionModel> get sections => _sections;

  set sections(List<SectionModel> value) {
    _sections = value;
    notifyListeners();
  }

  List<String> completeTask(TaskModel task) {
    task.isComplete = true;


    final updatedIds = <String>[];
    updatedIds.add(task.id);

    completeChildren(task.children, updatedIds);
    return updatedIds;
  }

  void completeChildren(List<TaskModel> tasks, List<String> updateIds) {
    for (final task in tasks) {
      if (!task.isComplete) {
        updateIds.add(task.id);
      }
      task.isComplete = true;
      completeChildren(task.children, updateIds);
    }
  }

  void uncompleteTask(TaskModel task) {
    task.isComplete = false;
  }

  void addTask(TaskModel task, SectionModel? section) {
    if (section == null) {
      sections.first.addTask(task);
      return;
    }

    section.addTask(task);
  }

  void removeTask(TaskModel task) => sections = [
    for (final section in sections)
      if (section != task) section
  ];

  void reorderTasks() {
    final newSections = <SectionModel>[];

    for(final section in sections) {
      section.tasks.sort((left, right) {
        if (left.isComplete == right.isComplete) return 0;
        if (left.isComplete) return 1;
        return -1;
      });

      newSections.add(section);
    }

    sections = newSections;
  }
}