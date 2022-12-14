import 'package:flutter/material.dart';

class Person with ChangeNotifier {
  final String id;
  final String name;
  final String imgProfile;
  final String occupation;

  Person({
    required this.id,
    required this.name,
    required this.imgProfile,
    required this.occupation,
  });
}
