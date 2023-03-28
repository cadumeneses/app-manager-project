class ProjectModel {
  final String id;
  final String name;
  final String description;
  final DateTime? createDate;
  final String imgUrl;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    this.createDate,
    required this.imgUrl,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createDate: json['createDate'] != null
          ? DateTime.parse(json['createDate'])
          : null,
      imgUrl: json['imgUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createDate': createDate?.toIso8601String(),
      'imgUrl': imgUrl,
    };
  }
}
