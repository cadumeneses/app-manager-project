import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/form/input_submit_form.dart';
import '../../../core/components/form/input_text_form.dart';
import '../../project/models/project_model.dart';
import '../../project/presenters/project_presenter.dart';
import '../presenters/team_presenter.dart';

class TeamForm extends StatefulWidget {
  const TeamForm({super.key});

  @override
  State<TeamForm> createState() => _TeamFormState();
}

class _TeamFormState extends State<TeamForm> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();

  late TeamPresenter presenter;
  late ProjectPresenter projectPresenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read();
    projectPresenter = context.read();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    projectPresenter.loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    List<ProjectModel> projects = projectPresenter.projects;
    ProjectModel projectSelected = projects.first;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 40,
                  color: Colors.grey.shade400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Text(
                  'Adicionar nova equipe',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              InputTextForm(
                label: "Nome",
                minLenght: 3,
                controller: _teamNameController,
              ),
              const SizedBox(height: 20),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: DropdownButton<ProjectModel>(
                    value: projectSelected,
                    hint: Text(
                      projectSelected.name,
                    ),
                    onChanged: (ProjectModel? selectedProject) {
                      if (selectedProject != null) {
                        setState(() {
                          projectSelected = selectedProject;
                          print(projectSelected);
                        });
                      }
                    },
                    items: projects.map<DropdownMenuItem<ProjectModel>>(
                        (ProjectModel project) {
                      return DropdownMenuItem<ProjectModel>(
                        value: project,
                        child: Text(project.name),
                      );
                    }).toList(),
                  )),
              const SizedBox(height: 20),
              InputSubmitForm(
                color: colorScheme.primary,
                submitForm: () {
                  presenter.saveBoard(
                    _teamNameController.text,
                    'widget.projectId',
                  );
                  Navigator.of(context).pop();
                },
                nameButton: 'Adicionar Equipe',
                labelColor: colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
