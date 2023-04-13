import 'package:app_manager_project/features/team/models/person_model.dart';

class TeamModel {
  final String teamId;
  final List<PersonModel> people;
  final String projectId;

  TeamModel({
    required this.people,
    required this.teamId,
    required this.projectId,
  });
}
