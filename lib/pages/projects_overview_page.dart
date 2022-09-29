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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: Row(
                  children: const [
                    Text(
                      "Manager",
                      style: TextStyle(
                          fontFamily: "Barlow",
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Projects",
                      style: TextStyle(
                          fontFamily: "Barlow",
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const ProjectSearchComponent(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Meus projetos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Mostrar todos',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10, left: 20),
                width: double.infinity,
                height: 250,
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
                padding: const EdgeInsets.only(left:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tarefas do dia',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Mostrar todas',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 500,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
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