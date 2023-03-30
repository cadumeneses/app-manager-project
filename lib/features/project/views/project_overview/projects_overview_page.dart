import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_manager_project/features/project/presenters/project_presenter.dart';
import 'package:app_manager_project/core/task/presenters/task_presenter.dart';
import 'package:app_manager_project/core/task/components/task_item_component.dart';
import 'package:app_manager_project/features/project/views/components/project_item_component.dart';
import '../../../../core/utils/app_routes.dart';
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
    context.read<ProjectPresenter>().loadProjects();
    context.read<TaskPresenter>().loadAllTasks();
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
                onActionPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                    AppRoutes.projects,
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.only(right: 5, left: 20),
                width: double.infinity,
                height: 300,
                child: ListView.separated(
                  itemCount: context.watch<ProjectPresenter>().projects.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemBuilder: ((context, index) {
                    var project =
                        context.watch<ProjectPresenter>().projects[index];
                    return ProjectItemComponent(
                      name: project.name,
                      imgUrl: project.imgUrl,
                      description: project.description,
                      project: project,
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              HeadingWithAction(
                headingText: 'Tarefas do dia',
                actionText: 'Mostrar todas',
                onActionPressed: () {},
              ),
              context.watch<TaskPresenter>().allTasks.isEmpty
                  ? const Center(child: Text('Nenhuma tarefa encontrada'))
                  : SizedBox(
                      height:
                          context.watch<TaskPresenter>().allTasks.length * 75,
                      width: double.infinity,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            context.watch<TaskPresenter>().allTasks.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          var task =
                              context.watch<TaskPresenter>().allTasks[index];
                          return TaskItemComponent(
                            task: task,
                            onChanged: (V) {},
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
