import 'package:app_manager_project/core/task/components/task_card_component.dart';
import 'package:app_manager_project/core/task/components/task_form_component.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../infra/models/board_model.dart';

class BoardComponent extends StatelessWidget {
  const BoardComponent({required this.board, super.key});
  final Board board;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 0,
        color: colorScheme.background,
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          board.name,
                          style: textTheme.labelLarge,
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          maxRadius: 22,
                          backgroundColor: colorScheme.secondaryContainer,
                          child: CircleAvatar(
                            backgroundColor: colorScheme.tertiaryContainer,
                            foregroundColor: colorScheme.onTertiaryContainer,
                            maxRadius: 20,
                            child: const Text('0'),
                          ),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          showModal(context);
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.squarePlus,
                          color: colorScheme.primaryContainer,
                        ))
                  ]),
            ),
            const TaskCardComponent(),
          ],
        ),
      ),
    );
  }
}

void showModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (_) {
        return const TaskFormComponent();
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))));
}
