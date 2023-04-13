import 'package:app_manager_project/features/team/models/person_model.dart';
import 'package:app_manager_project/features/team/models/person_repository.dart';
import 'package:flutter/material.dart';

class PersonPresenter with ChangeNotifier {
  final PersonRepository _personRepository;
  bool _isLoading = false;
  String _error = '';
  List<PersonModel> _persons = [];
  List<PersonModel> get persons => [..._persons];

  PersonPresenter(this._personRepository);

  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadPersons(String teamId) async {
    _isLoading = true;
    _error = '';
    try {
      _persons = await _personRepository.loadPersons(teamId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveBoard(
    String firstName,
    String lastName,
    String teamId,
  ) async {
    _isLoading = true;
    _error = '';
    try {
      await _personRepository.savePerson(
        PersonModel(
          id: '',
          teamId: teamId,
          firstName: firstName,
          lastName: lastName,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      loadPersons(teamId);
      notifyListeners();
    }
  }
}
