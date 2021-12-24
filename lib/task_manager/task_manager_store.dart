import 'package:flutter/cupertino.dart';

import 'task_manager_model.dart';

class TaskManagerStore extends ChangeNotifier {
  TaskManagerStore() {
    _taskList = TaskListModel(this);
  }
  late TaskListModel _taskList;
  set taskList(TaskListModel value) {
    _taskList = value;
    notifyListeners();
  }
  TaskListModel get taskList => _taskList;
}