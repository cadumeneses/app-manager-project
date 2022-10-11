import 'dart:io';

import 'package:app_manager_project/src/modules/project/domain/failures/project_failures.dart';
import 'package:app_manager_project/src/modules/project/infra/datasources/iproject_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:app_manager_project/src/modules/project/infra/models/load_model.dart';
import 'package:dio/dio.dart';

class ConnectionData implements ILoadDataSource {
  var dio = Dio(
    BaseOptions(
        baseUrl:
            'https://manager-projects-flutter-default-rtdb.firebaseio.com/',
        connectTimeout: 5000,
        receiveTimeout: 5000,
        validateStatus: (int? status) {
          return status != null && status > 0;
        },
        headers: {
          HttpHeaders.userAgentHeader: 'dio',
          'common-header': 'xx',
        },
        contentType: 'application/json'),
  );

  @override
  Future<Either<ProjectFailures, List<LoadModel>>> loadProjects(
      String id,
      String name,
      String description,
      DateTime createDate,
      String imgUrl) async {
    try {
      final response = await dio.get('projects.json');

      if (response.statusCode == 200) {
        final jsonList = response.data as List;
        final list = jsonList
            .map((map) => LoadModel.fromMap(map as Map<String, dynamic>))
            .toList();
        return right(list);
      } else {
        return left(ProjectFailures());
      }
    } catch (e) {
      return left(ProjectFailures());
    }
  }
}
