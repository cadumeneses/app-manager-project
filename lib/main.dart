import 'package:app_manager_project/pages/project_detail_page.dart';
import 'package:app_manager_project/pages/projects_overview_page.dart';
import 'package:app_manager_project/pages/projects_page.dart';
import 'package:app_manager_project/store/project.store.dart';
import 'package:app_manager_project/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'models/project.dart';
import 'pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProjectStore>(
          create: (_) => ProjectStore(),
        ),
        Provider<Project>(
          create: (_) => Project(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: Colors.blue,
            secondary: Colors.purple
          ),
          textTheme: ThemeData().textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'Barlow',
            ),
          ),
        ),
        routes: {
          AppRoutes.home: (ctx) => const Home(),
          AppRoutes.projects: (ctx) => const ProjectsPage(),
          AppRoutes.projectsOverview: (ctx) => const ProjectsOverviewPage(),
          AppRoutes.projectsDetails: (ctx) => const ProjectDetailPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
