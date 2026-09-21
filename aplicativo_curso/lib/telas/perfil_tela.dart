import 'package:flutter/material.dart';

import 'editar_perfil_tela.dart';

/// Tela com as informações do estudante, o atalho para editar o perfil
/// e as opções extras (modo escuro e sobre o aplicativo).
class PerfilTela extends StatelessWidget {
  const PerfilTela({
    super.key,
    required this.escuro,
    required this.aoAlternarTema,
  });

  final bool escuro;
  final VoidCallback aoAlternarTema;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Center(
          child: CircleAvatar(
            radius: 48,
            backgroundColor: cores.primary,
            child: Icon(Icons.person, size: 56, color: cores.onPrimary),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Estudante de Flutter',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text('estudante@email.com', textAlign: TextAlign.center),
        const SizedBox(height: 24),

        // ---- Informações do estudante ----
        Card(
          child: Column(
            children: const [
              ListTile(
                leading: Icon(Icons.school),
                title: Text('Curso atual'),
                subtitle: Text('Flutter Básico'),
              ),
              ListTile(
                leading: Icon(Icons.menu_book),
                title: Text('Cursos iniciados'),
                subtitle: Text('4 cursos'),
              ),
              ListTile(
                leading: Icon(Icons.play_lesson_outlined),
                title: Text('Aulas concluídas'),
                subtitle: Text('18 aulas'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditarPerfilTela(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Editar perfil'),
          ),
        ),
        const SizedBox(height: 20),

        // ---- Funcionalidades extras ----
        Card(
          child: Column(
            children: [
              SwitchListTile(
                secondary: Icon(
                  escuro ? Icons.dark_mode : Icons.light_mode,
                ),
                title: const Text('Modo escuro'),
                subtitle: const Text('Alterne o tema do aplicativo'),
                value: escuro,
                onChanged: (valor) => aoAlternarTema(),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Sobre o aplicativo'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'App Cursos',
                    applicationVersion: '1.0.0',
                    children: const [
                      Text(
                        'Aplicativo de cursos criado nas aulas de Flutter '
                        'com telas de início, cursos, favoritos e perfil.',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
