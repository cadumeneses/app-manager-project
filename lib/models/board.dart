import 'package:app_manager_project/models/task.dart';

class Board {
  final String id;
  final String name;
  final List<Task>? tasks;

  Board({
    required this.id,
    required this.name,
    this.tasks,
  });
}
