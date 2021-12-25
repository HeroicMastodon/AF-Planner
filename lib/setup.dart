import 'package:af_planner/task_manager/task_manager_store.dart';
import 'package:af_planner/task_manager/models/task_model.dart';
import 'package:af_planner/task_manager/task_manager_service.dart';
import 'package:get_it/get_it.dart';

void setup() {
  configureTasks();
}

void configureTasks() {
  GetIt.I.registerSingleton(TaskManagerStore());
  GetIt.I.registerSingleton(TaskManagerService());
  
  // TODO: remove
  final tasks = GetIt.I.get<TaskManagerService>().store.taskList;
  for(int i = 0; i < 10; i++) {
    final task = TaskModel();
    task.name = i.toString();
    task.description = i % 2 == 0 ? "" : "description";
    task.priority = i % 4;
    task.dueDate = DateTime(2021, i, i);

    tasks.addTask(task);
  }
}