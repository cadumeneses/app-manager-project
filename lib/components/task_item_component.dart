import 'package:app_manager_project/components/task_checkbox_component.dart';
import 'package:flutter/material.dart';

import '../utils/custom_color.dart';

class TaskItemComponent extends StatelessWidget {
  const TaskItemComponent({required this.nameTask, super.key});

  final String nameTask;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameTask,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.primaryColor
                  ),
                ),
                const Text(
                  'Today - 07:00 AM',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                )
              ],
            ),
            const TaskCheckboxComponent(),
          ],
        ),
      ),
    );
  }
}
