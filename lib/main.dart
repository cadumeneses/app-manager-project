import 'package:app_manager_project/pages/projects_page.dart';
import 'package:app_manager_project/store/project.store.dart';
import 'package:app_manager_project/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'pages/projects_overview_page.dart';
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
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.home:(ctx) => const ProjectsOverviewPage(),
          AppRoutes.projects:(ctx) => const ProjectsPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
