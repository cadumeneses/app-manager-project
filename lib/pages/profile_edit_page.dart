import 'package:flutter/material.dart';

import '../models/person.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Person person = ModalRoute.of(context)?.settings.arguments as Person;
    return SingleChildScrollView(
      child: Scaffold(
        body: Center(child: Text(person.name)),
      ),
    );
  }
}
