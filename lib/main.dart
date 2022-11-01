import 'package:app_manager_project/models/board_repository.dart';
import 'package:app_manager_project/models/person_repository.dart';
import 'package:app_manager_project/models/project_list.dart';
import 'package:app_manager_project/pages/auth_or_home.dart';
import 'package:app_manager_project/pages/project_detail_page.dart';
import 'package:app_manager_project/pages/projects_overview_page.dart';
import 'package:app_manager_project/pages/projects_page.dart';
import 'package:app_manager_project/utils/app_routes.dart';
import 'package:provider/provider.dart';

import 'models/auth.dart';
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
                auth.token ?? '', auth.uid ?? '', previous?.projects ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, BoardRepository>(
          create: (_) => BoardRepository(),
          update: (ctx, auth, previous) {
            return BoardRepository(
                auth.token ?? '', auth.uid ?? '', previous?.boards ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, PersonRepository>(
          create: (_) => PersonRepository(),
          update: (ctx, auth, previous) {
            return PersonRepository(
                auth.token ?? '', auth.uid ?? '', previous?.people ?? []);
          },
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: const Color(0xFFF56E28)),
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
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
