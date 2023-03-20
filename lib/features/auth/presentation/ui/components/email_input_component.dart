import 'package:flutter/material.dart';

import '../../../../../core/utils/custom_color.dart';

class EmailInputComponent extends StatelessWidget {
  const EmailInputComponent({
    super.key,
    required Map<String, String> authData,
  }) : _authData = authData;

  final Map<String, String> _authData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.white),
      )),
      child: TextFormField(
        style: const TextStyle(
          color: CustomColor.whiteColor,
        ),
        decoration: const InputDecoration(
          hintText: "E-mail",
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        keyboardType: TextInputType.emailAddress,
        onSaved: (email) => _authData['email'] = email ?? '',
        validator: (_email) {
          final email = _email ?? '';
          if (email.trim().isEmpty || !email.contains('@')) {
            return 'Insira um e-mail válido!';
          }
          return null;
        },
      ),
    );
  }
}