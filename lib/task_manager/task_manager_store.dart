import 'package:af_planner/task_manager/models/section_model.dart';
import 'package:flutter/material.dart';

import 'models/task_list_model.dart';
import 'models/task_model.dart';

class TaskManagerStore extends ChangeNotifier {
  TaskListModel _taskList = TaskListModel();

  set taskList(TaskListModel value) {
    _taskList = value;
    notifyListeners();
  }

  TaskListModel get taskList => _taskList;

  final Map<String, TaskModel> _taskMap = {};
  final Map<String, SectionModel> _sectionMap = {};

  void addTask(TaskModel task) {
    final section = task.sectionId != null ? _sectionMap[task.sectionId] : null;
    task.section = section;

    _taskMap.putIfAbsent(task.id, () => task);
    _taskList.addTask(task, section);
  }

  TaskModel? getTask(String id) {
    return _taskMap[id];
  }

  void removeTask(TaskModel task) {
    _taskMap.remove(task.id);

    if (task.parentId != null) {
      final parent = _taskMap[task.parentId];
      parent?.children.remove(task);
      parent?.children = [...parent.children];
    }

    if (task.sectionId == null) {
      _taskList.unassignedTasks = [
        for (final ut in taskList.unassignedTasks)
          if (ut.id != task.id) ut
      ];
    } else {
      final section = _sectionMap[task.sectionId];
      section?.tasks.remove(task);
      section?.tasks = [...section.tasks];
    }
  }

  List<String> completeTask(TaskModel task) {
    task.isComplete = true;
    final ids = [task.id];
    if (task.children.isEmpty) return ids;

    taskList.completeChildren(task.children, ids);
    return ids;
  }

  List<String> uncompleteTask(TaskModel task) {
    task.isComplete = false;
    final ids = [task.id];

    if (task.parentId == null) return ids;

    var parent = _taskMap[task.parentId];

    while (parent != null) {
      parent.isComplete = false;
      ids.add(parent.id);
      parent = _taskMap[parent.parentId];
    }

    return ids;
  }

  void initializeStore(List<TaskModel> tasks, List<SectionModel> sections) {
    _sectionMap.clear();
    _taskMap.clear();
    taskList.unassignedTasks.clear();

    for (final section in sections) {
      _sectionMap.putIfAbsent(section.id, () => section);
    }

    for (final task in tasks) {
      _taskMap.putIfAbsent(task.id, () => task);
    }

    for (final task in tasks) {
      if (task.sectionId == null && task.parentId == null) {
        taskList.addTask(task, null);
      } else {
        final section = _sectionMap[task.sectionId];
        section?.addTask(task);
      }

      if (task.parentId == null) {
        continue;
      }

      final parent = _taskMap[task.parentId];
      parent?.addChild(task);
    }

    taskList.sections = sections;
  }
}
