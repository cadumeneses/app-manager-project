import 'package:app_manager_project/components/project_form_component.dart';
import 'package:app_manager_project/models/project_list.dart';
import 'package:app_manager_project/pages/auth_or_home.dart';
import 'package:app_manager_project/pages/project_detail_page.dart';
import 'package:app_manager_project/pages/projects_overview_page.dart';
import 'package:app_manager_project/pages/projects_page.dart';
import 'package:app_manager_project/store/project.store.dart';
import 'package:app_manager_project/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'models/auth.dart';
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
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProjectList>(
          create: (_) => ProjectList(),
          update: (ctx, auth, previous) {
            return ProjectList(
              auth.token ?? '', auth.uid ?? '', previous?.projects ?? []
            );
          },
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: Colors.blue, secondary: Colors.purple),
          textTheme: ThemeData().textTheme.copyWith(
                headline6: const TextStyle(
                  fontFamily: 'Barlow',
                ),
              ),
        ),
        routes: {
          AppRoutes.auth_or_home: (ctx) => const AuthOrHomePage(),
          AppRoutes.projects: (ctx) => const ProjectsPage(),
          AppRoutes.projectsOverview: (ctx) => const ProjectsOverviewPage(),
          AppRoutes.projectsDetails: (ctx) => const ProjectDetailPage(),
          AppRoutes.projectNew: (ctx) => const ProjectFormComponent(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
