import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';

import '../components/project_item_component.dart';
import '../components/project_search_component.dart';
import '../components/task_item_component.dart';

class ProjectsOverviewPage extends StatelessWidget {
  const ProjectsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: Text(
                  "Manager Projects",
                  style: TextStyle(
                      fontFamily: "Barlow",
                      color: CustomColor.primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const ProjectSearchComponent(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Meus Projetos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: CustomColor.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10, left: 20),
                width: double.infinity,
                height: 260,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ProjectItemComponent(),
                    ProjectItemComponent(),
                    ProjectItemComponent(),
                    ProjectItemComponent(),
                    ProjectItemComponent(),
                    ProjectItemComponent(),
                    ProjectItemComponent(),
                    ProjectItemComponent(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Tarefas do dia',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: CustomColor.primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 500,
                width: double.infinity,
                padding: const EdgeInsets.only(right: 10, left: 20),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: const [
                    TaskItemComponent(nameTask: 'Teste'),
                    TaskItemComponent(nameTask: 'Front end'),
                    TaskItemComponent(nameTask: 'Back ed'),
                    TaskItemComponent(nameTask: 'DBA'),
                    TaskItemComponent(nameTask: 'Review'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
