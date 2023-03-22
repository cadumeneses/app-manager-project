import 'package:flutter/material.dart';

class InputTextForm extends StatelessWidget {
  const InputTextForm(
      {required this.formData,
      required this.formDataTitle,
      required this.titleFocus,
      this.controller,
      required this.label,
      required this.minLenght,
      super.key});
  final FocusNode titleFocus;
  final Map<String, Object> formData;
  final String formDataTitle;
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
        initialValue: formData[formDataTitle]?.toString(),
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
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(titleFocus);
        },
        autofocus: false,
        onSaved: (name) => formData[formDataTitle] = name ?? '',
        validator: (name) {
          final title = name ?? '';

          if (title.trim().isEmpty) {
            return 'O $formDataTitle é inválido!';
          }

          if (title.trim().length < minLenght) {
            return 'O $formDataTitle precisa de um tamanho minímo: $minLenght.';
          }
          return null;
        },
      ),
    );
  }
}
