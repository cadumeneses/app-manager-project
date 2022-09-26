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
    return Checkbox(
      value: check,
      onChanged: (value) {
        setState(() {
          check = value!;
        });
      },
    );
  }
}
