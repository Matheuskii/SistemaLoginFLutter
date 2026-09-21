import 'package:flutter/material.dart';

/// Modelo simples que representa um curso do aplicativo.
class Curso {
  final String nome;
  final String descricao;
  final int aulas;
  final IconData icone;

  const Curso(this.nome, this.descricao, this.aulas, this.icone);
}

/// Cursos disponíveis no aplicativo.
const List<Curso> cursos = [
  Curso(
    'Flutter Básico',
    'Curso introdutório sobre desenvolvimento mobile utilizando Flutter.',
    12,
    Icons.flutter_dash,
  ),
  Curso(
    'Dart Essencial',
    'Aprenda a linguagem Dart do zero, com listas, funções e classes.',
    10,
    Icons.code,
  ),
  Curso(
    'Interface Mobile',
    'Crie telas bonitas e organizadas com Widgets, temas e layouts.',
    8,
    Icons.phone_android,
  ),
  Curso(
    'Conexão com API',
    'Consuma dados da internet e mostre as informações nas telas.',
    14,
    Icons.cloud_download,
  ),
  Curso(
    'Banco de Dados',
    'Guarde e recupere as informações dos usuários do aplicativo.',
    16,
    Icons.storage,
  ),
  Curso(
    'Desenvolvimento Mobile',
    'Boas práticas para publicar e manter aplicativos móveis.',
    20,
    Icons.rocket_launch,
  ),
];

/// Cursos que já aparecem favoritados quando o aplicativo abre.
const List<String> favoritosIniciais = [
  'Flutter Básico',
  'Interface Mobile',
  'Banco de Dados',
];
