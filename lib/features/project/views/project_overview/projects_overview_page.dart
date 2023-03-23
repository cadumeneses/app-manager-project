import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_manager_project/core/task/components/task_item_component.dart';
import 'package:app_manager_project/features/project/views/components/project_item_component.dart';
import 'package:app_manager_project/features/project/models/project_repository.dart';
import 'components/heading_with_action.dart';
import 'components/project_search_component.dart';

class ProjectsOverviewPage extends StatefulWidget {
  const ProjectsOverviewPage({super.key});

  @override
  State<ProjectsOverviewPage> createState() => _ProjectsOverviewPageState();
}

class _ProjectsOverviewPageState extends State<ProjectsOverviewPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<ProjectRepository>(context, listen: false).loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 30,
                ),
                child: Text(
                  "TaskForce",
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const ProjectSearchComponent(),
              const SizedBox(height: 20),
              HeadingWithAction(
                headingText: 'Meus Projetos',
                actionText: 'Mostrar todos',
                onActionPressed: () {},
              ),
              Container(
                padding: const EdgeInsets.only(right: 5, left: 20),
                width: double.infinity,
                height: 300,
                child: Consumer<ProjectRepository>(
                    builder: (_, projectRepository, widget) {
                  return ListView.separated(
                      itemCount: projectRepository.projects.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: ((context, index) {
                        var project = projectRepository.projects[index];
                        return ProjectItemComponent(
                          name: project.name,
                          imgUrl: project.imgUrl,
                          description: project.description,
                          project: project,
                        );
                      }));
                }),
              ),
              const SizedBox(height: 20),
              HeadingWithAction(
                headingText: 'Tarefas do dia',
                actionText: 'Mostrar todas',
                onActionPressed: () {},
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
