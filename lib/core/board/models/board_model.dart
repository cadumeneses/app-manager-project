class BoardModel {
  final String id;
  final String name;
  final String projectId;
  final DateTime? dataVersion;

  BoardModel({
    required this.id,
    required this.name,
    required this.projectId,
    required this.dataVersion,
  });
}
