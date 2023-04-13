import 'dart:math';

import 'package:app_manager_project/features/team/models/person_model.dart';
import 'package:flutter/foundation.dart';

import '../../../core/external/dio/dio_client.dart';

class PersonRepository {
  var dio = DioClient();

  final String _token;
  final String _uid;

  List<PersonModel> _persons;
  List<PersonModel> get teams => [..._persons];

  PersonRepository([
    this._token = '',
    this._uid = '',
    this._persons = const [],
  ]);

  Future<List<PersonModel>> loadPersons(String teamId) async {
    try {
      final response = await dio.dio.get(
        'persons.json?auth=$_token',
      );

      if (response.data == null) {
        return [];
      }

      Map<String, dynamic> data = response.data;
      List<PersonModel> persons = [];

      if (data.isEmpty) {
        _persons = [];
      }

      data.forEach((personId, personData) {
        if (personData['teamId'] == teamId) {
          try {
            PersonModel board = PersonModel(
              id: personId,
              teamId: personData['teamId'],
              firstName: personData['firstName'],
              lastName: personData['lastName'],
            );
            persons.add(board);
          } catch (e) {
            rethrow;
          }
          if (!listEquals(_persons, persons)) {
            _persons = persons;
          }
        }
      });

      return _persons;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> savePerson(PersonModel data) async {
    bool hasId = data.teamId.isNotEmpty;

    final person = PersonModel(
      id: hasId ? data.id : Random().nextDouble().toString(),
      teamId: data.teamId,
      firstName: data.firstName,
      lastName: data.lastName,
    );

    if (hasId) {
      return;
    } else {
      return await addPerson(person);
    }
  }

  Future<void> addPerson(PersonModel person) async {
    final response = await dio.dio.post(
      'persons.json?auth=$_token',
      data: {
        "id": person.id,
        "teamId": person.teamId,
        "firstName":person.firstName,
        "lastName":person.lastName,
      },
    );

    final id = response.data["name"];

    _persons.add(
      PersonModel(
        id: id,
        teamId: person.teamId,
        firstName: person.firstName,
        lastName: person.lastName,
      ),
    );
  }
}
