import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Project extends Equatable with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final DateTime? createDate;
  final String? imgUrl;

  Project({
     required this.id,
     required this.name,
     required this.description,
     this.createDate,
     this.imgUrl,
  });
  
  @override
  List<Object?> get props => [id, name, description, createDate, imgUrl];
}