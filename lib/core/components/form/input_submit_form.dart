import 'package:flutter/material.dart';

class InputSubmitForm extends StatelessWidget {
  const InputSubmitForm({
    required this.color,
    required this.submitForm,
    required this.nameButton,
    required this.labelColor,
    super.key,
  });

  final Color color;
  final Color labelColor;
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
        width: MediaQuery.of(context).size.width * 0.82,
        child: Center(
          child: Text(
            nameButton,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: labelColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
