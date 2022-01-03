import 'package:af_planner/task_manager/models/section_model.dart';
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

  final firstSection = SectionModel();
  addTasksToSection(firstSection);
  tasks.sections.add(firstSection);


  for (int i = 0; i < 3; i++) {
    final section = SectionModel();
    section.position = i+1;
    section.name = 'Section ${section.position}';

    addTasksToSection(section);

    tasks.sections.add(section);
  }

}

void addTasksToSection(SectionModel section) {
  
  for (int k = 0; k < 4; k++) {
    final task = TaskModel();
    task.name = k.toString();
    task.description = k % 2 == 0 ? "" : "description";
    task.priority = k % 4;
    task.dueDate = DateTime(2021, k, k);
  
    for (int j = 0; j < 3; j++) {
      final subtask = TaskModel();
      subtask.name = (k + j).toString();
      task.children.add(subtask);
    }
  
    section.addTask(task);
  }
}
