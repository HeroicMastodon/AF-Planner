import 'package:af_planner/task_manager/models/section_model.dart';
import 'package:af_planner/task_manager/task_manager_store.dart';
import 'package:af_planner/task_manager/models/task_model.dart';
import 'package:get_it/get_it.dart';

class TaskManagerService {
  void toggleCompletion(TaskModel task, bool? complete) {
    task.isComplete = complete ?? false;
  }

  final TaskManagerStore store = GetIt.I.get<TaskManagerStore>();

  void addTask(TaskModel task, SectionModel? section) {
    store.addTask(task);
  }

  void removeTask(TaskModel task) {
    store.removeTask(task);
  }

  void completeTask(TaskModel task) {
    store.completeTask(task);
  }

  void updateTask(TaskModel task) {
    store.updateTask(task);
  }

  void uncompleteTask(TaskModel task) {
    store.uncompleteTask(task);
  }
}