import 'package:app_manager_project/core/task/components/task_form_component.dart';
import 'package:app_manager_project/core/task/components/task_item_component.dart';
import 'package:app_manager_project/core/task/presenters/task_presenter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../features/project/models/project_model.dart';
import '../models/board_model.dart';

class BoardView extends StatefulWidget {
  const BoardView({
    super.key,
    required this.board,
    required this.project,
  });
  final BoardModel board;
  final ProjectModel project;

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  late TaskPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read<TaskPresenter>();
    if (mounted) {
      presenter.loadTasks(widget.project.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final taskPresenterWatch = context.watch<TaskPresenter>();

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: ShapeDecoration(
      color: colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.board.name,
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      maxRadius: 22,
                      backgroundColor: colorScheme.primary,
                      child: CircleAvatar(
                        backgroundColor: colorScheme.secondaryContainer,
                        foregroundColor: colorScheme.primary,
                        maxRadius: 20,
                        child: Text(
                          taskPresenterWatch.tasks.length.toString(),
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    showModal(context, widget.project);
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.squarePlus,
                    color: colorScheme.onSecondaryContainer,
                  ),
                )
              ],
            ),
          ),
          taskPresenterWatch.isLoading
              ? const Center(child: CircularProgressIndicator())
              : taskPresenterWatch.error.isNotEmpty
                  ? Text(
                      taskPresenterWatch.error,
                      style: TextStyle(color: colorScheme.error),
                    )
                  : Expanded(
                      child: ListView.separated(
                        itemCount: taskPresenterWatch.tasks.length,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(10),
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          var task = taskPresenterWatch.tasks[index];
                          return TaskItemComponent(
                            task: task,
                            onChanged: (V) {
                              taskPresenterWatch.updateTaskStatus(task);
                            },
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}

void showModal(BuildContext context, ProjectModel project) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return TaskFormComponent(
        projectId: project.id,
      );
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}
