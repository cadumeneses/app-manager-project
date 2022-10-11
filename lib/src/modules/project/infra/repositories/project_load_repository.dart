import 'package:app_manager_project/src/modules/project/domain/failures/project_failures.dart';
import 'package:app_manager_project/src/modules/project/infra/datasources/iproject_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:app_manager_project/src/modules/project/infra/models/load_model.dart';

class ProjectLoadRepository implements ILoadDataSource {
  ProjectLoadRepository({
    required ILoadDataSource loadDataSource,
  }) : _loadDataSource =  loadDataSource;
  final ILoadDataSource _loadDataSource;

  @override
  Future<Either<ProjectFailures, List<LoadModel>>> loadProjects(String id, String name, String description, DateTime createDate, String imgUrl) {
    return _loadDataSource.loadProjects(id, name, description, createDate, imgUrl);
  }
}
