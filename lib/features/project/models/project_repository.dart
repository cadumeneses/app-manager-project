import 'dart:math';
import 'package:app_manager_project/features/project/models/project_model.dart';
import 'package:flutter/foundation.dart';

import '../../../core/external/dio/dio_client.dart';

class ProjectRepository with ChangeNotifier {
  var dio = DioClient();
  final String _token;
  final String _uid;
  Project project = Project(id: "", name: "", description: "", imgUrl: "");

  List<Project> _projects = [];
  List<Project> get projects => [..._projects];

  set projects(List<Project> projects) => _projects = projects;

  int get projectsCount {
    return _projects.length;
  }

  ProjectRepository([
    this._token = '',
    this._uid = '',
    this._projects = const [],
  ]);

  Future<void> loadProjects() async {
    try {
      final response = await dio.dio.get('projects.json?auth=$_token');

      Map<String, dynamic> data = response.data;

      List<Project> newProjects = [];
      data.forEach((projectId, projectData) {
        try {
          Project project = Project(
            id: projectId,
            name: projectData['name'],
            description: projectData['description'],
            createDate: DateTime.parse(projectData['createDate']),
            imgUrl: projectData['imgUrl'],
          );
          newProjects.add(project);
        } catch (e) {
          // Tratar erros específicos de cada projeto aqui
        }
      });

      if (!listEquals(_projects, newProjects)) {
        _projects = newProjects;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveProject(Map<String, dynamic> data) async {
    bool hasId = data['id'] != null;

    final project = Project(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'],
      imgUrl: "assets/images/ondas.jpg",
    );

    if (hasId) {
      return await updateProject(project);
    } else {
      return await addProject(project);
    }
  }

  Future<void> addProject(Project project) async {
    final date = DateTime.now();
    final response = await dio.dio.post(
      ('https://taskforce-47f99-default-rtdb.firebaseio.com/projects.json?auth=$_token'),
      data: {
        "name": project.name,
        "description": project.description,
        "imgUrl": "assets/images/ondas.jpg",
        "createDate": date.toIso8601String(),
      },
    );

    final id = response.data['name'];
    _projects.add(Project(
        id: id,
        name: project.name,
        description: project.description,
        createDate: project.createDate,
        imgUrl: project.imgUrl));
    notifyListeners();
  }

  Future<void> updateProject(Project project) async {
    int index = _projects.indexWhere((element) => element.id == project.id);

    if (index >= 0) {
      await dio.dio.patch(
        'https://taskforce-47f99-default-rtdb.firebaseio.com/project.id.json?auth=$_token',
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
