class TaskModel {
  final String id;
  final String name;
  final DateTime? dateInit;
  final String projectId;

  TaskModel({
    required this.id,
    required this.name,
    this.dateInit,
    required this.projectId,
  });
}