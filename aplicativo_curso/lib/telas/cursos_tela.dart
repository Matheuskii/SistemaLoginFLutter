import 'package:flutter/material.dart';

import '../modelos/curso.dart';
import '../widgets/curso_card.dart';

/// Tela que lista os cursos e permite pesquisar e favoritar.
class CursosTela extends StatefulWidget {
  const CursosTela({
    super.key,
    required this.favoritos,
    required this.aoFavoritar,
    required this.aoAbrir,
  });

  final List<String> favoritos;
  final void Function(String nome) aoFavoritar;
  final void Function(Curso curso) aoAbrir;

  @override
  State<CursosTela> createState() => _CursosTelaState();
}

class _CursosTelaState extends State<CursosTela> {
  String busca = '';

  @override
  Widget build(BuildContext context) {
    final encontrados = cursos
        .where((curso) => curso.nome.toLowerCase().contains(busca.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            onChanged: (valor) {
              setState(() {
                busca = valor;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Pesquisar curso',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: encontrados.isEmpty
              ? const Center(child: Text('Nenhum curso encontrado.'))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: encontrados.length,
                  itemBuilder: (context, posicao) {
                    final curso = encontrados[posicao];

                    return CursoCard(
                      curso: curso,
                      favorito: widget.favoritos.contains(curso.nome),
                      aoFavoritar: (selecionado) =>
                          widget.aoFavoritar(selecionado.nome),
                      aoAbrir: widget.aoAbrir,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
