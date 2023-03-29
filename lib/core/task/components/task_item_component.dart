import 'package:app_manager_project/core/task/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskItemComponent extends StatelessWidget {
  const TaskItemComponent({
    super.key,
    required this.onChanged,
    required this.task,
  });

  final void Function(bool?)? onChanged;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 65,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: colorScheme.tertiary,
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
                  task.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  task.dateInit.toString(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey,
                      ),
                )
              ],
            ),
            Checkbox(
              value: task.status,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return colorScheme.primary;
                }
                return colorScheme.primary;
              }),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
