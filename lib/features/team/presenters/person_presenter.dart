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

  Future<void> loadPersons() async {
    _isLoading = true;
    _error = '';
    try {
      _persons = await _personRepository.loadPersons();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> savePerson(
    String firstName,
    String lastName,
    String occupation,
  ) async {
    _isLoading = true;
    _error = '';
    try {
      await _personRepository.savePerson(
        PersonModel(
          id: '',
          firstName: firstName,
          lastName: lastName,
          occupation: occupation,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
