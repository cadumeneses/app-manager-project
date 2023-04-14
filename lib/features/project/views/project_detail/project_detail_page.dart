import 'package:app_manager_project/core/board/presenters/board_presenter.dart';
import 'package:app_manager_project/core/board/views/board_form_view.dart';
import 'package:app_manager_project/features/project/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/board/views/board_view.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late BoardPresenter presenter;
  late ProjectModel project;
  bool _isDataLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    project = ModalRoute.of(context)?.settings.arguments as ProjectModel;
    presenter = context.read<BoardPresenter>();

    if (mounted) {
      if (!_isDataLoaded) {
        presenter.loadBoards(project.id);
        _isDataLoaded = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final boardPresenter = context.watch<BoardPresenter>();

    return Scaffold(
      backgroundColor: colorScheme.background,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        onPressed: () {
          showModal(context, project);
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: IconThemeData(color: colorScheme.primary),
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
                    bottom: 20
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: boardPresenter.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : boardPresenter.boards.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                color: colorScheme.tertiaryContainer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Nenhum quadro encontrado', style: textTheme.titleMedium,),
                                  InkWell(
                                    onTap: () => showModal(context, project),
                                    child: Text('Adicionar Placa', style: textTheme.titleMedium?.copyWith(color: colorScheme.primary),),
                                  )
                                ],
                              ),
                            )
                          : ListView.separated(
                              itemCount: boardPresenter.boards.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 20),
                              itemBuilder: ((context, index) {
                                var board = boardPresenter.boards[index];
                                return BoardView(
                                  board: board,
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

void showModal(BuildContext context, ProjectModel project) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.background,
    builder: (_) {
      return BoardFormView(
        projectId: project.id,
      );
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}
