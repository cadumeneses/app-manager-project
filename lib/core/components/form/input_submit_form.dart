import 'package:flutter/material.dart';

class InputSubmitForm extends StatelessWidget {
  const InputSubmitForm(
      {required this.color,
      required this.submitForm,
      required this.nameButton,
      super.key});

  final Color color;
  final void Function() submitForm;
  final String nameButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: submitForm,
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Center(
          child: Text(
            nameButton,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
