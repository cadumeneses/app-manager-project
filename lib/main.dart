import 'package:app_manager_project/core/board/presenters/board_presenter.dart';
import 'package:app_manager_project/features/profile/presenters/profile_presenter.dart';
import 'package:app_manager_project/features/project/models/project_repository.dart';
import 'package:app_manager_project/features/auth/models/auth_model.dart';
import 'package:app_manager_project/features/project/presenters/project_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/board/models/board_repository.dart';
import 'core/task/models/task_repository.dart';
import 'core/task/presenters/task_presenter.dart';
import 'core/theme/themes.dart';
import 'core/utils/app_routes.dart';
import 'features/auth/views/auth_page.dart';
import 'features/home/presentation/ui/home_page.dart';
import 'features/profile/models/profile_repository.dart';
import 'features/project/views/my_projects/my_projects_page.dart';
import 'features/project/views/project_detail/project_detail_page.dart';
import 'features/project/views/project_overview/projects_overview_page.dart';

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
          create: (_) => AuthModel(),
        ),
        ChangeNotifierProvider<ProjectPresenter>(
          create: (context) => ProjectPresenter(ProjectRepository()),
        ),
        ChangeNotifierProvider<TaskPresenter>(
          create: (context) => TaskPresenter(TaskRepository()),
        ),
        ChangeNotifierProvider<BoardPresenter>(
          create: (context) => BoardPresenter(BoardRepository()),
        ),
        ChangeNotifierProvider<ProfilePresenter>(
          create: (context) => ProfilePresenter(ProfileRepository()),
        ),
      ],
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        routes: {
          AppRoutes.auth_or_home: (ctx) => const AuthOrHomePage(),
          AppRoutes.projects: (ctx) => const MyProjectsPage(),
          AppRoutes.projectsOverview: (ctx) => const ProjectsOverviewPage(),
          AppRoutes.projectsDetails: (ctx) => const ProjectDetailPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthModel auth = Provider.of(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return auth.isAuth ? const HomePage() : AuthPage();
        }
      },
    );
  }
}
