import 'package:app_manager_project/features/team/view/team_form_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../presenters/person_presenter.dart';

class TeamView extends StatefulWidget {
  const TeamView({super.key});

  @override
  State<TeamView> createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  late PersonPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read();
    presenter.loadPersons();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    presenter = context.watch<PersonPresenter>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final people = List.generate(presenter.persons.length, (i) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(
            '${presenter.persons[i].firstName[0]} ${presenter.persons[i].lastName[0]}',
          ),
        ),
        title: Text(
            '${presenter.persons[i].firstName} ${presenter.persons[i].lastName}'),
        subtitle: Text(presenter.persons[i].occupation),
      );
    });

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModal(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 30,
              ),
              child: Text(
                "Minha Equipe",
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 222,
              width: double.infinity,
              child: ListView(children: people),
            )
          ],
        ),
      ),
    );
  }
}

void showModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.background,
    builder: (_) {
      return const TeamForm();
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}
