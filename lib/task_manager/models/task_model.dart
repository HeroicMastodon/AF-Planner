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

  SectionModel? _section;
  set section(SectionModel? value) {
    _section = value;
    notifyListeners();
  }
  SectionModel? get section => _section;
}
