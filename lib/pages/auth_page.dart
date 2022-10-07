import 'package:app_manager_project/components/auth_form.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
            Container(
              padding: const EdgeInsets.only(bottom: 50),
              width: MediaQuery.of(context).size.width * 0.6,
              child: const Text(
                'Entre na sua conta',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const AuthForm(),
          ]),
        ),
      ),
    );
  }
}
