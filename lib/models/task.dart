class Task {
  final String? id;
  final String? name;
  final DateTime? dateInit;
  // final DateTime? dateFinish;
  final String? projectId;

  Task({
    this.id,
    this.name,
    this.dateInit,
    // this.dateFinish,
    this.projectId,
  });
}

class Tasks {
  final String? id;
  final List<Task>? tasks;

  Tasks({
    this.tasks,
    this.id,
  });
}
