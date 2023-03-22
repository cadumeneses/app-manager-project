import 'package:app_manager_project/features/auth/infra/repositories/auth_repository.dart';
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/brisa_logo1.png',
                    height: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Perfil",
                    style: textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    style: textTheme.titleMedium,
                  ),
                )
              ],
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '27',
                        style: textTheme.labelLarge,
                      ),
                      Text('Projetos', style: textTheme.labelLarge)
                    ],
                  ),
                  const VerticalDivider(color: Colors.grey, thickness: 1),
                  Column(
                    children: [
                      Text(
                        '189',
                        style: textTheme.labelLarge,
                      ),
                      Text(
                        'Tarefas',
                        style: textTheme.labelLarge,
                      )
                    ],
                  ),
                  const VerticalDivider(color: Colors.grey, thickness: 1),
                  Column(
                    children: [
                      Text('4', style: textTheme.labelLarge),
                      Text('Equipes', style: textTheme.labelLarge)
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Editar Perfil'),
              onTap: () {
                showModalForm(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove_red_eye),
              title: const Text('Mudar tema'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ajuda'),
              onTap: () {},
            ),
            ListTile(
              iconColor: colorScheme.error,
              leading: const Icon(Icons.exit_to_app),
              title: Text(
                'Logout',
                style: textTheme.labelLarge,
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
            style: textTheme.titleLarge,
          ),
          const Divider(),
          Text(
            'Tem certeza que quer sair?',
            style: textTheme.titleMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: () {
                Provider.of<AuthRepository>(context, listen: false).logout();
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.auth_or_home);
              },
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: Text('Sim, quero sair', style: textTheme.titleMedium),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.background,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
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
