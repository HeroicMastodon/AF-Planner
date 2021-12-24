import 'package:af_planner/task_manager/tasks_model.dart';
import 'package:af_planner/task_manager/tasks_service.dart';
import 'package:get_it/get_it.dart';

void setup() {
  configureTasks();
}

void configureTasks() {
  GetIt.I.registerSingleton(TaskListModel());
  GetIt.I.registerSingleton(TasksService());
  
  // TODO: remove
  final tasks = GetIt.I.get<TaskListModel>().tasks;
  for(int i = 0; i < 10; i++) {
    final task = TaskModel();
    task.name = i.toString();
    task.description = i % 2 == 0 ? "" : "description";
    task.priority = i % 4;
    task.dueDate = DateTime(2021, i, i);

    tasks.add(task);
  }
}