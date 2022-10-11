import '../../domain/enteties/project.dart';

class LoadModel extends Project {
  LoadModel({
    required String id,
    required String name,
    required String description,
    required DateTime? createDate,
    required String? imgUrl,
  }) : super(
          id: id,
          name: name,
          description: description,
          createDate: createDate,
          imgUrl: imgUrl,
        );
  static LoadModel fromMap(Map<String, dynamic> map) {
    return LoadModel(
      id: map['name'],
      name: map['name'],
      description: map['description'],
      createDate: map['createDate'],
      imgUrl: map['imgUrl'],
    );
  }
}
