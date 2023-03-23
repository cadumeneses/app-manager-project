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
  final VoidCallback submitForm;
  final String nameButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: submitForm,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.82,
        decoration: ShapeDecoration(
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
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
