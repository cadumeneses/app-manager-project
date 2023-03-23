class TaskModel {
  final String id;
  final String name;
  final String? dateInit;
  final String projectId;

  TaskModel({
    required this.id,
    required this.name,
    this.dateInit,
    required this.projectId,
  });
}
