import 'package:app_manager_project/models/task.dart';
import 'package:flutter/cupertino.dart';

class Board with ChangeNotifier{
  String id;
  String name;
  List<Task>? tasks;

  Board({
    required this.id,
    required this.name,
    this.tasks,
  });
}
