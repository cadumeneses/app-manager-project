import 'package:app_manager_project/features/auth/models/auth_model.dart';
import 'package:app_manager_project/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/profile_form_component.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    Color dividerColor = Colors.grey.shade200;
    Color labelColor = colorScheme.onBackground.withOpacity(0.7);

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 30,
              ),
              child: Text(
                "Perfil",
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    minRadius: 35,
                    maxRadius: 50,
                    child: Image.asset(
                      'assets/images/sorriso 1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Text(
                      'Monkey D. Luffy',
                      style: textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '27',
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Projetos',
                          style: textTheme.labelLarge?.copyWith(
                            color: labelColor,
                          ))
                    ],
                  ),
                  VerticalDivider(color: dividerColor, thickness: 1),
                  Column(
                    children: [
                      Text(
                        '189',
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Tarefas',
                        style: textTheme.labelLarge?.copyWith(
                          color: labelColor,
                        ),
                      )
                    ],
                  ),
                  VerticalDivider(color: dividerColor, thickness: 1),
                  Column(
                    children: [
                      Text(
                        '4',
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Equipes',
                          style: textTheme.labelLarge?.copyWith(
                            color: labelColor,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: dividerColor,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: colorScheme.onBackground,
              ),
              title: const Text('Editar Perfil'),
              onTap: () {
                showModalForm(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.remove_red_eye_outlined,
                color: colorScheme.onBackground,
              ),
              title: const Text('Mudar tema'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.help_outline,
                color: colorScheme.onBackground,
              ),
              title: const Text('Ajuda'),
              onTap: () {},
            ),
            ListTile(
              iconColor: colorScheme.error,
              leading: const Icon(Icons.exit_to_app_outlined),
              title: Text(
                'Logout',
                style: textTheme.labelLarge?.copyWith(color: colorScheme.error),
              ),
              onTap: () => showModal(context),
            ),
          ],
        ),
      ),
    );
  }
}

void showModalForm(BuildContext context) {
  showBottomSheet(
    context: context,
    builder: (_) {
      return const ProfileFormComponent();
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}

void showModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return const LogoutModal();
    },
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
  );
}

class LogoutModal extends StatelessWidget {
  const LogoutModal({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 40,
              color: colorScheme.onBackground,
            ),
          ),
          Text(
            'Logout',
            style: textTheme.titleLarge?.copyWith(
              color: colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          Text(
            'Tem certeza que quer sair?',
            style: textTheme.titleMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: InkWell(
              onTap: () {
                Provider.of<AuthModel>(context, listen: false).logout();
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.auth_or_home);
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: ShapeDecoration(
                  color: colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Sim, quero sair',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: ShapeDecoration(
                color: colorScheme.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  'Cancelar',
                  style: textTheme.titleMedium,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
