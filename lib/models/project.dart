class Project {
  final String id;
  final String name;
  final String description;
  final DateTime? createDate;
  final DateTime? finalDate;
  final String? teamName;
  final String? imgUrl;
  final bool? todo;
  final bool? progress;
  final bool? test;
  final bool? finish;
  final String? teamId;
  final String? taskId;

  Project({
     required this.id,
     required this.name,
     required this.description,
     this.createDate,
     this.teamName,
     this.finalDate,
     this.imgUrl,
     this.todo,
     this.progress,
     this.test,
     this.finish,
     this.taskId,
     this.teamId,
  });
}