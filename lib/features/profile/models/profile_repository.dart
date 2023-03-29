import 'dart:math';
import 'package:app_manager_project/features/profile/models/profile_model.dart';
import '../../../core/external/dio/dio_client.dart';

class ProfileRepository {
  final _client = DioClient();
  final String _token;
  final String _uid;
  List<ProfileModel> people = [];
  List<ProfileModel> get peoples => [...people];

  int get peopleCount {
    return peoples.length;
  }

  ProfileRepository([
    this._token = '',
    this._uid = '',
    this.people = const [],
  ]);

  Future<void> savePerson(Map<String, dynamic> data) async {
    bool hasId = data['id'] != null;

    final person = ProfileModel(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      imgProfile: data['imgProfile'] as String,
      occupation: data['occupation'],
    );

    if (hasId) {
      return;
    } else {
      return await addPerson(person);
    }
  }

  Future<void> addPerson(ProfileModel person) async {
    final response = await _client.dio.post(
        ('https://manager-projects-flutter-default-rtdb.firebaseio.com/person/$_uid.json.json?auth=$_token'),
        data: {
          "name": person.name,
          "imgProfile": person.imgProfile,
          "occupation": person.occupation,
        });

    final id = response.data["name"];
    people.add(ProfileModel(
      id: id,
      name: person.name,
      imgProfile: person.imgProfile,
      occupation: person.occupation,
    ));
  }
}
