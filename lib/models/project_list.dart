import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/project.dart';
import '../services/dio.dart';

class ProjectList with ChangeNotifier {
  var dio = DioClient();

  List<Project> _projects = [];
  List<Project> get projects => [..._projects];

  int get projectsCount {
    return _projects.length;
  }

  ProjectList([
    this._projects = const [],
  ]);

  Future<void> loadProjects() async {
    _projects.clear();

    try {
      final response = await dio.dio.get('projects.json');
      Map<String, dynamic> data = response.data;

      data.forEach((projectId, projectData) {
        _projects.add(
          Project(
            id: projectId,
            name: projectData['name'],
            description: projectData['description'],
          ),
        );
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveProject(Map<String, dynamic> data) {
    bool hasId = data['id'] != null;

    final project = Project(
      id: hasId ? data['name'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'],
    );

    if (hasId) {
      return updateProject(project);
    } else {
      debugPrint(project.toString());
      return addProject(project);
    }
  }

  Future<void> addProject(Project project) async {
    final response = await dio.dio.post(
      ('https://manager-projects-flutter-default-rtdb.firebaseio.com/projects.json'),
      data: {
        "name": project.name,
        "description": project.description,
      },
    );

    final id = response.data['id'];
    _projects.add(Project(
      id: id,
      name: project.name,
      description: project.description,
    ));
    notifyListeners();
  }

  Future<void> updateProject(Project project) async {
    int index = _projects.indexWhere((element) => element.id == project.id);

    if (index >= 0) {
      await dio.dio.patch(
        'https://manager-projects-flutter-default-rtdb.firebaseio.com/projects/project.id.json',
        data: {
          "name": project.name,
          "description": project.description,
        },
      );
      _projects[index] = project;
      notifyListeners();
    }
  }
}
