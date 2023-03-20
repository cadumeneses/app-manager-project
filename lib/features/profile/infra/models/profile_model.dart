import 'package:flutter/material.dart';

class ProfileModel with ChangeNotifier {
  final String id;
  final String name;
  final String imgProfile;
  final String occupation;

  ProfileModel({
    required this.id,
    required this.name,
    required this.imgProfile,
    required this.occupation,
  });
}
