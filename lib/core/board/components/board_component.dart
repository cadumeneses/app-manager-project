import 'package:app_manager_project/core/task/components/task_form_component.dart';
import 'package:app_manager_project/core/task/components/task_item_component.dart';
import 'package:app_manager_project/core/task/infra/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../features/project/infra/models/project_model.dart';
import '../../task/infra/repositories/tasks_repository.dart';
import '../infra/models/board_model.dart';

class BoardComponent extends StatefulWidget {
  const BoardComponent({
    super.key,
    required this.board,
    required this.project,
  });
  final Board board;
  final Project project;

  @override
  State<BoardComponent> createState() => _BoardComponentState();
}

class _BoardComponentState extends State<BoardComponent> {
  @override
  void initState() {
    super.initState();
    _loadTasks(context);
  }

  List<TaskModel>? tasks;

  Future<void> _loadTasks(BuildContext context) async {
    final taskRepository = Provider.of<TaskRepository>(
      context,
      listen: false,
    );
    await taskRepository.loadTasks(widget.project.id);
    setState(() {
      tasks = taskRepository.tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 0,
        color: colorScheme.tertiaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                          color: colorScheme.onTertiaryContainer,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        maxRadius: 22,
                        backgroundColor: colorScheme.primary,
                        child: CircleAvatar(
                          backgroundColor: colorScheme.tertiaryContainer,
                          foregroundColor: colorScheme.onTertiaryContainer,
                          maxRadius: 20,
                          child: tasks == null
                              ? const SizedBox()
                              : Text(
                                  tasks!.length.toString(),
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
                      color: colorScheme.onTertiaryContainer,
                    ),
                  )
                ],
              ),
            ),
            tasks == null
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.separated(
                      itemCount: tasks!.length,
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: ((context, index) {
                        var task = tasks![index];
                        return TaskItemComponent(
                          nameTask: task.name,
                        );
                      }),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

void showModal(BuildContext context, Project project) {
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
