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

  addTestTasks();

}

void addTestTasks() {
  final sectionList = <SectionModel>[];
  final taskList = <TaskModel>[];

  for (int i = 0; i < 3; i++) {
    String? sectionId;
    if (i > 0) {
      final section = SectionModel();
      sectionId = section.id;
      section.name = "Section $i";
      section.position = i;

      sectionList.add(section);
    }

    for (int j = 0; j < 3; j++) {
      final task = TaskModel();
      task.name = j.toString();
      taskList.add(task);
      task.sectionId = sectionId;

      for (int k = 0; k < 3; k++) {
        final child = TaskModel();
        child.name = "child $k";
        child.parentId = task.id;
        taskList.add(child);

        // for (int l = 0; l < 3; l++) {
        //   final grandChild = TaskModel();
        //   grandChild.name = "grand child $l";
        //   grandChild.parentId = child.id;
        //   taskList.add(grandChild);
        // }
      }
    }
  }

  final store = GetIt.I.get<TaskManagerStore>();
  store.initializeStore(taskList, sectionList);
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
