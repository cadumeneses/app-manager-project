import 'package:app_manager_project/features/profile/models/profile_repository.dart';
import 'package:flutter/material.dart';

class ProfilePresenter with ChangeNotifier {
  final ProfileRepository _profileRepository;

  bool _isLoading =  false;
  String _error = '';

  ProfilePresenter(this._profileRepository);

  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> saveProfile(Map<String, dynamic> data) async {
    _isLoading = true;
    _error = '';

    try {
      await _profileRepository.savePerson(data);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}