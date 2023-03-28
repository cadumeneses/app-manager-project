class TaskModel {
  final String id;
  final String name;
  final String? dateInit;
  final String projectId;
  final bool status;

  TaskModel({
    required this.id,
    required this.name,
    this.dateInit,
    required this.projectId,
    this.status = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      dateInit: json['dateInit'],
      projectId: json['projectId'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateInit': dateInit,
      'projectId': projectId,
      'status': status,
    };
  }
}
