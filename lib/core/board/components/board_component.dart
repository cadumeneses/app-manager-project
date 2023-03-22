import 'package:app_manager_project/core/task/components/task_card_component.dart';
import 'package:app_manager_project/core/task/components/task_form_component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../features/project/infra/models/project_model.dart';
import '../infra/models/board_model.dart';

class BoardComponent extends StatelessWidget {
  const BoardComponent({
    required this.board,
    super.key,
    required this.project,
  });
  final Board board;
  final Project project;

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
                          board.name,
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
                            child: Text(
                              '0',
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
                        showModal(context, project);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.squarePlus,
                        color: colorScheme.onTertiaryContainer,
                      ),
                    )
                  ]),
            ),
            const TaskCardComponent(),
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
