import 'package:flutter/cupertino.dart';

class Board with ChangeNotifier{
  String id;
  String name;

  Board({
    required this.id,
    required this.name,
  });
}
