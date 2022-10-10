import 'package:app_manager_project/models/project_list.dart';
import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/project_item_component.dart';
import '../components/project_search_component.dart';
import '../components/task_item_component.dart';

class ProjectsOverviewPage extends StatefulWidget {
  const ProjectsOverviewPage({super.key});

  @override
  State<ProjectsOverviewPage> createState() => _ProjectsOverviewPageState();
}

class _ProjectsOverviewPageState extends State<ProjectsOverviewPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProjectList>(
      context,
      listen: false,
    ).loadProjects().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> _onRefresh(BuildContext context) async {
    await Provider.of<ProjectList>(
      context,
      listen: false,
    ).loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    final ProjectList projectList = Provider.of(context);

    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      color: CustomColor.secondaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: CustomColor.backgroundColor,
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
                    children: [
                      Image.asset(
                        'assets/images/brisa_logo1.png',
                        height: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Manager Projects",
                        style: TextStyle(
                            fontFamily: "Barlow",
                            color: CustomColor.primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                  child: ListView.builder(
                    itemCount: projectList.projectsCount,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ProjectItemComponent(
                        projectItem: projectList.projects[index],
                      );
                    },
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
      ),
    );
  }
}
