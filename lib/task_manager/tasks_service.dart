import 'package:af_planner/task_manager/tasks_model.dart';
import 'package:get_it/get_it.dart';

class TasksService {
  void toggleCompletion(TaskModel task, bool? complete) {
    task.isComplete = complete ?? false;
  }

  final TaskListModel _taskListModel = GetIt.I.get<TaskListModel>();

  void addTask(TaskModel task) {
    _taskListModel.addTask(task);
  }

  void removeTask(TaskModel task) {
    _taskListModel.removeTask(task);
  }

  void updateTask(TaskModel task, int index) {
    _taskListModel.updateTask(task, index);
  }
}