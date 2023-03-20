import 'package:app_manager_project/core/utils/custom_color.dart';
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
      fillColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return CustomColor.secondaryColor.withOpacity(.32);
        }
        return CustomColor.secondaryColor;
      }),
      onChanged: (value) {
        setState(() {
          check = value!;
        });
      },
    );
  }
}
