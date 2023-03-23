import 'package:flutter/material.dart';

class InputTextForm extends StatelessWidget {
  const InputTextForm({
    this.controller,
    required this.label,
    required this.minLenght,
    super.key,
  });
  final String label;
  final TextEditingController? controller;
  final int minLenght;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        color: colorScheme.outline.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: theme.textTheme.labelLarge?.copyWith(
            color: colorScheme.outline.withOpacity(0.8),
          ),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        textInputAction: TextInputAction.next,
        autofocus: false,
        controller: controller,
        validator: (name) {
          final title = name ?? '';
          return null;
        },
      ),
    );
  }
}
