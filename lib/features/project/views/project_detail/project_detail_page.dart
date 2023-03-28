import 'package:app_manager_project/core/board/views/board_view.dart';
import 'package:app_manager_project/core/board/models/board_repository.dart';
import 'package:app_manager_project/features/project/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<BoardRepository>().loadBoards();
  }
  
  @override
  Widget build(BuildContext context) {
    final Project project =
        ModalRoute.of(context)?.settings.arguments as Project;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: colorScheme.primaryContainer),
            actions: const [
              Icon(Icons.search, size: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.more_vert, size: 30),
              )
            ],
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: SizedBox(
                height: 20,
                width: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/images/brisa_logo1.png',
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/ondas.jpg',
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, 0.8),
                        end: Alignment(0, 0),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.2),
                          Color.fromRGBO(0, 0, 0, 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  child: Text(
                    project.name.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  child: Text(
                    project.description,
                    textAlign: TextAlign.left,
                    style: textTheme.titleSmall?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 10,
                    left: 20,
                    top: MediaQuery.of(context).size.height * 0.015,
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    itemCount: context.watch<BoardRepository>().boards.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      var board = context.watch<BoardRepository>().boards[index];
                      return BoardComponent(
                        board: board,
                        project: project,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
