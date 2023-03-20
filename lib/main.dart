import 'package:app_manager_project/features/project/infra/repositories/project_repository.dart';
import 'package:app_manager_project/features/auth/infra/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/board/infra/repositories/board_repository.dart';
import 'core/task/infra/repositories/tasks_repository.dart';
import 'core/utils/app_routes.dart';
import 'features/auth/presentation/ui/auth_page.dart';
import 'features/home/presentation/ui/home_page.dart';
import 'features/project/presentation/ui/my_projects/my_projects_page.dart';
import 'features/profile/infra/repositories/profile_repository.dart';
import 'features/project/presentation/ui/project_detail/project_detail_page.dart';
import 'features/project/presentation/ui/projects_overview/projects_overview_page.dart';

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
          create: (_) => AuthRepository(),
        ),
        ChangeNotifierProxyProvider<AuthRepository, ProjectRepository>(
          create: (_) => ProjectRepository(),
          update: (ctx, auth, previous) {
            return ProjectRepository(
                auth.token ?? '', auth.uid ?? '', previous?.projects ?? []);
          },
        ),
        ChangeNotifierProxyProvider<AuthRepository, BoardRepository>(
          create: (_) => BoardRepository(),
          update: (ctx, auth, previous) {
            return BoardRepository(
                auth.token ?? '', auth.uid ?? '', previous?.boards ?? []);
          },
        ),
        ChangeNotifierProxyProvider<AuthRepository, ProfileRepository>(
          create: (_) => ProfileRepository(),
          update: (ctx, auth, previous) {
            return ProfileRepository(
                auth.token ?? '', auth.uid ?? '', previous?.people ?? []);
          },
        ),
        ChangeNotifierProxyProvider<AuthRepository, TaskRepository>(
          create: (_) => TaskRepository(),
          update: (ctx, auth, previous) {
            return TaskRepository(
                auth.token ?? '', auth.uid ?? '', previous?.tasks ?? []);
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
    AuthRepository auth = Provider.of(context);
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
          return auth.isAuth ? const HomePage() : const AuthPage();
        }
      },
    );
  }
}
