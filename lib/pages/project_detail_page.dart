import 'package:app_manager_project/components/board_component.dart';
import 'package:app_manager_project/components/board_form_component.dart';
import 'package:app_manager_project/models/board.dart';
import 'package:app_manager_project/models/board_repository.dart';
import 'package:app_manager_project/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/project.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {

  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    Provider.of<BoardRepository>(
      context,
      listen: false,
    ).loadBoards().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    final Project project =
        ModalRoute.of(context)?.settings.arguments as Project;
    
    final provider = Provider.of<BoardRepository>(context);
    final List<Board> loadBoards = provider.boardItems;
    return Scaffold(
      backgroundColor: CustomColor.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: const IconThemeData(color: CustomColor.secondaryColor),
            actions: const [
              Icon(Icons.search),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Icon(Icons.more_vert),
              )
            ],
            expandedHeight: 250,
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
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 5),
                child: Text(
                  project.name.toUpperCase(),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 22,
                      color: CustomColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 5),
                child: Text(
                  project.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, right: 5, top: 20),
              //   child: InkWell(
              //     onTap: () => showModal(context),
              //     child: Container(
              //       height: 50,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: CustomColor.whiteColor,
              //           border: Border.all(
              //             color: CustomColor.primaryColor,
              //             width: 2,
              //           )),
              //       child: const Center(
              //         child: Padding(
              //           padding: EdgeInsets.all(10),
              //           child: Text(
              //             'Definir prazo do projeto',
              //             style: TextStyle(
              //                 color: CustomColor.primaryColor,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                  padding: const EdgeInsets.only(right: 10, left: 20, top: 10),
                  width: double.infinity,
                  height: 260,
                  child: Consumer<BoardRepository>(
                    builder: (_,boardRepository, widget) {
                      return ListView.builder(
                        itemCount: boardRepository.boardCount,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          var board = boardRepository.boardItems[index];
                          return BoardComponent(name: board.name);
                        })
                      );
                    }
                  ),
                ),
            ]),
          ),
        ],
      ),
    );
  }
}

void showModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (_) {
        return const BoardFormComponent();
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))));
}
