import 'dart:math';

import 'package:app_manager_project/models/person.dart';
import 'package:flutter/foundation.dart';

import '../services/dio.dart';

class PersonRepository with ChangeNotifier {
  var dio = DioClient();
  final String _token;
  final String _uid;
  List<Person> people = [];
  List<Person> get peoples => [...people];

  int get peopleCount {
    return peoples.length;
  }

  PersonRepository([
    this._token = '',
    this._uid = '',
    this.people = const [],
  ]);

  Future<void> savePerson(Map<String, dynamic> data) async {
    bool hasId = data['id'] != null;

    final person = Person(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      imgProfile: data['imgProfile'] as String,
      occupation: data['occupation'],
      uid: data['uid'],
    );

    if (hasId) {
      return;
    } else {
      return await addPerson(person);
    }
  }

  Future<void> addPerson(Person person) async {
    final response = await dio.dio.post(
      ('https://manager-projects-flutter-default-rtdb.firebaseio.com/person/$_uid.json.json?auth=$_token'),
      data:  {
        "name": person.name,
        "imgProfile": person.imgProfile,
        "occupation": person.occupation,
      }
    );

    final id = response.data["name"];
    final uid = response.data["uid"];
    people.add(Person(
      id: id,
      name: person.name,
      imgProfile: person.imgProfile,
      occupation: person.occupation,
      uid: uid,
    ));
    notifyListeners();
  }
}
