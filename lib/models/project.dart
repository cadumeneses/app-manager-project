class Project {
  final String id;
  final String name;
  final String description;
  final DateTime createDate;
  final DateTime finalDate;
  final String teamName;
  final String imgUrl;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.createDate,
    required this.teamName,
    required this.finalDate,
    required this.imgUrl,
  });
}