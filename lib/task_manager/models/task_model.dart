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
    newTask.copyFrom(this, includeId: includeId);

    return newTask;
  }

  void copyFrom(TaskModel src, { bool includeId = false}) {
    if (includeId) _id = src.id;
    _name = src.name;
    _description = src.description;
    _isComplete = src.isComplete;
    _children = src.children;
    _section = src.section;
    _sectionId = src.sectionId;
    _priority = src.priority;
    _dueDate = src.dueDate;
    notifyListeners();
  }
}
