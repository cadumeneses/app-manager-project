import 'package:app_manager_project/models/person.dart';
import 'package:flutter/foundation.dart';

import '../services/dio.dart';

class PersonRepository with ChangeNotifier {
  var dio = DioClient();
  final String _token;

  PersonRepository([
    this._token = '',
  ]);

  Future<void> addPerson(Person person) async {
    final response = await dio.dio.post(
      ('https://manager-projects-flutter-default-rtdb.firebaseio.com/person.json?auth=$_token'),
      data:  {
        "name": person.name,
        "imgProfile": person.imgProfile,
        "occupation": person.occupation,  
      }
    );

    final id = response.data["name"];
    notifyListeners();
  }
}
