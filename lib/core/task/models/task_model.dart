class TaskModel {
  final String id;
  final String name;
  final String? dateInit;
  final String boardId;

  TaskModel({
    required this.id,
    required this.name,
    this.dateInit,
    required this.boardId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      dateInit: json['dateInit'],
      boardId: json['board'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dateInit': dateInit,
      'boardId': boardId,
    };
  }
}
