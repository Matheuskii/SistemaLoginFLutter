import 'package:flutter/material.dart';

import '../modelos/curso.dart';
import '../widgets/curso_card.dart';

/// Tela que mostra apenas os cursos marcados como favoritos.
class FavoritosTela extends StatelessWidget {
  const FavoritosTela({
    super.key,
    required this.favoritos,
    required this.aoFavoritar,
    required this.aoAbrir,
  });

  final List<String> favoritos;
  final void Function(String nome) aoFavoritar;
  final void Function(Curso curso) aoAbrir;

  @override
  Widget build(BuildContext context) {
    final lista = cursos
        .where((curso) => favoritos.contains(curso.nome))
        .toList();

    if (lista.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum curso favorito ainda.\nToque no coração na tela de Cursos.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lista.length,
      itemBuilder: (context, posicao) {
        final curso = lista[posicao];

        return CursoCard(
          curso: curso,
          favorito: true,
          aoFavoritar: (selecionado) => aoFavoritar(selecionado.nome),
          aoAbrir: aoAbrir,
        );
      },
    );
  }
}
