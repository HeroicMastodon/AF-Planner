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
    store.taskList.addTask(task, section);
  }

  void removeTask(TaskModel task) {
    store.taskList.removeTask(task);
  }

  void completeTask(TaskModel task) {
    store.taskList.completeTask(task);
    store.taskList.reorderTasks();
  }

  void uncompleteTasks(List<TaskModel>tasks) {
    for (var task in tasks) {
      store.taskList.uncompleteTask(task);
    }
    store.taskList.reorderTasks();
  }
}