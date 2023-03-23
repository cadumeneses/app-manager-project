import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'storage_model.dart';
import 'auth_exception.dart';

class AuthModel with ChangeNotifier {
  var dio = Dio();
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;
  Timer? _logoutTime;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

  static const String _baseUrl =
      'https://identitytoolkit.googleapis.com/v1/accounts:';
  static const String _apiKey = 'AIzaSyAR5qSt2fP9U1GImlZg0r0Ute5dXPRm_Cc';
  String _urlForFragment(String fragment) => '$_baseUrl$fragment?key=$_apiKey';

  Future<void> _authenticate(
      String email, String password, String urlFragment) async {
    final url = _urlForFragment(urlFragment);
    final response = await dio.post((url), data: {
      "email": email,
      "password": password,
      "returnSecureToken": true
    });

    _handleAuthenticationResponse(response.data);
    _updateAuthenticationInfo();
  }

  void _handleAuthenticationResponse(Map<String, dynamic> response) {
    if (response['error'] != null) {
      throw AuthExceptionModel(response['error']['message']);
    } else {
      _token = response['idToken'];
      _email = response['email'];
      _uid = response['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(response['expiresIn']),
        ),
      );
    }
  }

  void _updateAuthenticationInfo() {
    StorageModel.saveMap('userData', {
      'token': _token,
      'email': _email,
      'uid': _uid,
      'expiryDate': _expiryDate!.toIso8601String(),
    });
    _autoLogout();
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await StorageModel.getMap('userData');

    if (userData.isEmpty) return;

    final expiryDate = DateTime.parse(userData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _uid = userData['uid'];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
  }

  void logout() {
    _token = null;
    _email = null;
    _uid = null;
    _expiryDate = null;
    _clearAutoTimer();
    StorageModel.remove('userData').then((_) {
      notifyListeners();
    });
  }

  void _clearAutoTimer() {
    _logoutTime?.cancel();
    _logoutTime = null;
  }

  void _autoLogout() {
    _clearAutoTimer();
    final timeToLogout = _expiryDate?.difference(DateTime.now()).inSeconds;
    _logoutTime = Timer(
      Duration(
        seconds: timeToLogout ?? 0,
      ),
      logout,
    );
  }
}
