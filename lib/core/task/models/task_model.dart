enum TaskStatus {
  inProgress,
  completed,
}

class TaskModel {
  final String id;
  final String name;
  final String? dateInit;
  final String projectId;
  TaskStatus status;

  TaskModel({
    required this.id,
    required this.name,
    this.dateInit,
    required this.projectId,
    this.status = TaskStatus.inProgress,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      dateInit: json['dateInit'],
      projectId: json['projectId'],
      status: json['status'] == 'completed' ? TaskStatus.completed : TaskStatus.inProgress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateInit': dateInit,
      'projectId': projectId,
      'status': status == TaskStatus.completed ? 'completed' : 'inProgress',
    };
  }

  bool get isCompleted => status == TaskStatus.completed;
}
