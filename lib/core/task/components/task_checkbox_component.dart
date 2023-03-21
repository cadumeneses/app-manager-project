import 'package:flutter/material.dart';

class TaskCheckboxComponent extends StatefulWidget {
  const TaskCheckboxComponent({super.key});

  @override
  State<TaskCheckboxComponent> createState() => _TaskCheckboxComponentState();
}

class _TaskCheckboxComponentState extends State<TaskCheckboxComponent> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Checkbox(
      value: check,
      fillColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.primary;
        }
        return colorScheme.primary;
      }),
      onChanged: (value) {
        setState(() {
          check = value!;
        });
      },
    );
  }
}
