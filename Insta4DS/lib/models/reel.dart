import 'package:flutter/material.dart';

/// Dados de um reel exibido na tela de reels.
class Reel {
  const Reel({
    required this.usuario,
    required this.descricao,
    required this.icone,
    required this.cor,
    required this.curtidas,
    required this.comentarios,
  });

  final String usuario;
  final String descricao;
  final IconData icone;
  final Color cor;
  final String curtidas;
  final String comentarios;
}

/// Modelos usados para montar as páginas de reels carregadas aos poucos.
///
/// O app ainda não tem servidor, então a lista abaixo é reutilizada pelas
/// páginas seguintes, simulando um acervo infinito de reels.
const List<Reel> modelosDeReels = [
  Reel(
    usuario: '@flutter.dev',
    descricao: 'Aprendendo Flutter de uma forma simples e prática',
    icone: Icons.play_circle,
    cor: Colors.deepPurple,
    curtidas: '2,5 mil',
    comentarios: '128',
  ),
  Reel(
    usuario: '@professor.mobile',
    descricao: 'Aula de desenvolvimento mobile concluída com sucesso',
    icone: Icons.school,
    cor: Colors.blue,
    curtidas: '1,8 mil',
    comentarios: '94',
  ),
  Reel(
    usuario: '@vitor.dev',
    descricao: 'Código limpo também é arte',
    icone: Icons.code,
    cor: Colors.teal,
    curtidas: '980',
    comentarios: '57',
  ),
  Reel(
    usuario: '@dart.lang',
    descricao: 'Dart e Flutter: a combinação perfeita para apps',
    icone: Icons.bolt,
    cor: Colors.indigo,
    curtidas: '3,1 mil',
    comentarios: '210',
  ),
  Reel(
    usuario: '@mobile.brasil',
    descricao: 'Dica do dia: teste seus widgets com flutter test',
    icone: Icons.bug_report,
    cor: Colors.orange,
    curtidas: '742',
    comentarios: '38',
  ),
  Reel(
    usuario: '@dev.senior',
    descricao: 'Do zero ao deploy com Flutter',
    icone: Icons.rocket_launch,
    cor: Colors.pink,
    curtidas: '5,4 mil',
    comentarios: '402',
  ),
];

/// Monta a página [pagina] de reels com [reelsPorPagina] itens.
///
/// Como o acervo é infinito, os modelos são reaproveitados na ordem em que
/// aparecem, ou seja, depois do último modelo a lista recomeça do primeiro.
List<Reel> gerarPaginaDeReels(int pagina, int reelsPorPagina) {
  return List.generate(reelsPorPagina, (indice) {
    final posicao = pagina * reelsPorPagina + indice;
    return modelosDeReels[posicao % modelosDeReels.length];
  });
}
