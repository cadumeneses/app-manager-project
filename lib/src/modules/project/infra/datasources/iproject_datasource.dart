import 'package:dartz/dartz.dart';

import '../../domain/failures/project_failures.dart';
import '../models/load_model.dart';

abstract class ILoadDataSource {
  Future<Either<ProjectFailures, List<LoadModel>>> loadProjects(String id, String name, String description, DateTime createDate, String imgUrl);
}