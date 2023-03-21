import 'package:flutter/material.dart';
import 'components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor:colorScheme.background,
      body: Column(
        children: [
          Expanded(
            child: Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    color: Colors.white),
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Entre na sua conta',
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
              ),
            ]),
          ),
          const AuthForm(),
        ],
      ),
    );
  }
}
