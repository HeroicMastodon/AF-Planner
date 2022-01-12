import 'package:af_planner/task_manager/models/section_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TaskModel extends ChangeNotifier {
  String _name = "";

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get name => _name;

  String _description = "";

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  String get description => _description;

  DateTime? _dueDate;

  set dueDate(DateTime? value) {
    _dueDate = value;
    notifyListeners();
  }

  DateTime? get dueDate => _dueDate;

  int? _priority;

  set priority(int? value) {
    _priority = value;
    notifyListeners();
  }

  int? get priority => _priority;

  List<String> _labels = [];

  set labels(List<String> value) {
    _labels = value;
    notifyListeners();
  }

  List<String> get labels => _labels;

  bool _isComplete = false;

  set isComplete(bool value) {
    _isComplete = value;
    notifyListeners();
  }

  bool get isComplete => _isComplete;

  String _id = const Uuid().v4();

  set id(String value) {
    _id = value;
    notifyListeners();
  }

  String get id => _id;

  String? _parentId;
  set parentId(String? value) {
    _parentId = value;
    notifyListeners();
  }
  String? get parentId => _parentId;

  List<TaskModel> _children = [];

  set children(List<TaskModel> value) {
    _children = value;
    notifyListeners();
  }

  List<TaskModel> get children => _children;

  void addChild(TaskModel value) {
    _children.add(value);
    notifyListeners();
  }

  void removeChild(TaskModel value) {
    _children.remove(value);
    notifyListeners();
  }

  String? _sectionId;
  set sectionId(String? value) {
    _sectionId = value;
    notifyListeners();
  }
  String? get sectionId => _sectionId;

  SectionModel? _section;
  set section(SectionModel? value) {
    _section = value;
    notifyListeners();
  }
  SectionModel? get section => _section;

  TaskModel clone({ bool includeId = false }) {
    var newTask = TaskModel();

    if (includeId) newTask.id = id;
    newTask.isComplete = isComplete;
    newTask.name = name;
    newTask.children = children;
    newTask.dueDate = dueDate;
    newTask.priority = priority;
    newTask.sectionId = sectionId;
    newTask.section = section;
    newTask.description = description;

    return newTask;
  }

  void copyFrom(TaskModel src, { bool includeId = false}) {
    if (includeId) id = src.id;
    name = src.name;
    description = src.description;
    isComplete = src.isComplete;
    children = src.children;
    section = src.section;
    sectionId = src.sectionId;
    priority = src.priority;
    dueDate = src.dueDate;
  }
}
