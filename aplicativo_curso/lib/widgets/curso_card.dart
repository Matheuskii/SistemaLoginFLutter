import 'package:flutter/material.dart';

import '../modelos/curso.dart';

/// Widget reutilizável que mostra as informações de um curso.
/// É usado na tela de Cursos e na tela de Favoritos.
class CursoCard extends StatelessWidget {
  const CursoCard({
    super.key,
    required this.curso,
    required this.favorito,
    required this.aoFavoritar,
    required this.aoAbrir,
  });

  final Curso curso;
  final bool favorito;
  final void Function(Curso curso) aoFavoritar;
  final void Function(Curso curso) aoAbrir;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: cores.primary,
                  child: Icon(curso.icone, color: cores.onPrimary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    curso.nome,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  tooltip: favorito
                      ? 'Remover dos favoritos'
                      : 'Adicionar aos favoritos',
                  onPressed: () => aoFavoritar(curso),
                  icon: Icon(
                    favorito ? Icons.favorite : Icons.favorite_border,
                    color: favorito ? Colors.redAccent : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(curso.descricao),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.play_lesson_outlined, size: 18, color: cores.primary),
                const SizedBox(width: 6),
                Text('${curso.aulas} aulas'),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => aoAbrir(curso),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Continuar curso'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
