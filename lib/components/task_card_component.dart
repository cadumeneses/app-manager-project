import 'package:app_manager_project/components/task_item_component.dart';
import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TaskCardComponent extends StatelessWidget {
  const TaskCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: InkWell(
        onTap: () {
          showModal(context);
        },
        child: const TaskItemComponent(nameTask: 'Teste'),
      ),
    );
  }
}

void showModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (_) {
        return const TaskDetailComponent();
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))));
}

class TaskDetailComponent extends StatelessWidget {
  const TaskDetailComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowLeft,
                    )),
                const Text(
                  'Nome da tarefa',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.star,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.peopleGroup,
                    color: Colors.grey.shade400),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Equipe',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: const [
                      CircleAvatar(maxRadius: 12),
                      CircleAvatar(maxRadius: 12),
                      CircleAvatar(maxRadius: 12),
                      CircleAvatar(maxRadius: 12),
                      CircleAvatar(maxRadius: 12),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.squarePlus,
                      color: CustomColor.secondaryColor,
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.user, color: Colors.grey.shade400),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Lider',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 73),
                  child: Row(
                    children: const [
                      CircleAvatar(maxRadius: 12),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Nome do lider'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.circleCheck,
                    color: Colors.grey.shade400),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Status',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: Container(
                    height: 30,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColor.primaryColor,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CustomColor.whiteColor,
                          border: Border.all(
                            color: CustomColor.primaryColor,
                            width: 2,
                          )),
                      child: const Center(
                        child: Text(
                          'Status',
                          style: TextStyle(
                              color: CustomColor.primaryColor, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.calendarCheck,
                    color: Colors.grey.shade400),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Vencimento',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text('31, dez de 2022'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
