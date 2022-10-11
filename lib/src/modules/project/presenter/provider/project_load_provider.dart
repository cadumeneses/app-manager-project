import 'package:app_manager_project/src/modules/project/domain/enteties/project.dart';
import 'package:app_manager_project/src/modules/project/domain/usecases/project_load.dart';
import 'package:flutter/material.dart';

class ProjectLoadProvider with ChangeNotifier{
  ProjectLoadProvider({
    required this.projectLoad,
  });
  final ProjectLoad projectLoad;

  Future<List<Project>> loadProjects(String id, String name,
      String description, DateTime createDate, String imgUrl) async {
    final result = await projectLoad(id, name, description, createDate, imgUrl);
    return result.fold((exception) => throw 'Falha ao carregar os projetos.',
        (results) => results);
  }
}
