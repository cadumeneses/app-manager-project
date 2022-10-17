import 'package:flutter/foundation.dart';

class Person with ChangeNotifier {
  final String id;
  final String name;
  final String imgProfile;

  Person({
    required this.id,
    required this.name,
    required this.imgProfile,
  });
}
