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

  void completeTask(TaskModel task, bool complete) {
    task.isComplete = complete;

    completeChildren(task.children, complete);
  }

  void completeChildren(List<TaskModel> tasks, bool complete) {
    for (final task in tasks) {
      task.isComplete = complete;
      completeChildren(task.children, complete);
    }
  }

  void addTask(TaskModel task, SectionModel? section) {
    if (section == null) {
      sections.first.addTask(task);
      return;
    }

    section.addTask(task);
  }

  void removeTask(TaskModel task) => sections = [
    for (final item in sections)
      if (item != task) item
  ];
}