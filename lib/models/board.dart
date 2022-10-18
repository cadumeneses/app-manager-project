import 'package:app_manager_project/models/task.dart';
import 'package:flutter/cupertino.dart';

class Board with ChangeNotifier{
  final String id;
  final String name;
  final List<Task>? tasks;

  Board({
    required this.id,
    required this.name,
    this.tasks,
  });
}
