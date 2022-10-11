import 'package:app_manager_project/src/modules/project/domain/enteties/project.dart';
import 'package:app_manager_project/src/modules/project/domain/failures/project_failures.dart';
import 'package:app_manager_project/src/modules/project/domain/repositories/iproject_repository.dart';
import 'package:dartz/dartz.dart';

mixin ProjectLoad {
  Future<Either<ProjectFailures, List<Project>>> call(String id, String name, String description, DateTime createDate, String imgUrl);
}

class ProjectLoadImpl implements ProjectLoad {
  ProjectLoadImpl(this._projectRepository, {
    required IProjectRepository projectRepository,
  });
  final IProjectRepository _projectRepository;
  
  @override
  Future<Either<ProjectFailures, List<Project>>> call(String id, String name, String description, DateTime createDate, String imgUrl) {
    return _projectRepository.loadProjects(id, name, description, createDate, imgUrl);
  }
}