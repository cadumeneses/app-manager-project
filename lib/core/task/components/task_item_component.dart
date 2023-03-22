import 'package:app_manager_project/core/task/components/task_checkbox_component.dart';
import 'package:flutter/material.dart';

class TaskItemComponent extends StatelessWidget {
  const TaskItemComponent({required this.nameTask, super.key});

  final String nameTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Today - 07:00 AM',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey,
                      ),
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
