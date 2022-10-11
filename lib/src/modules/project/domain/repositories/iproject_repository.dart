import 'package:app_manager_project/src/modules/project/domain/enteties/project.dart';
import 'package:dartz/dartz.dart';

import '../failures/project_failures.dart';

abstract class IProjectRepository {
  Future<Either<ProjectFailures, List<Project>>> loadProjects(String id, String name, String description, DateTime createDate, String imgUrl);
}