import 'package:aplicativo_curso/modelos/curso.dart';
import 'package:aplicativo_curso/telas/cursos_tela.dart';
import 'package:aplicativo_curso/telas/favoritos_tela.dart';
import 'package:aplicativo_curso/telas/inicio_tela.dart';
import 'package:aplicativo_curso/telas/perfil_tela.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

/// Monta o tema claro e o tema escuro do aplicativo.
ThemeData criarTema(Brightness brilho) {
  final cores = ColorScheme.fromSeed(
    seedColor: const Color(0xFF4527A0),
    brightness: brilho,
  );

  return ThemeData(
    colorScheme: cores,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: cores.primary,
      foregroundColor: cores.onPrimary,
      elevation: 2,
    ),
    cardTheme: CardThemeData(
      color: cores.surfaceContainerHighest,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: cores.primaryContainer,
      indicatorColor: cores.primary,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: cores.onPrimaryContainer,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (estados) => IconThemeData(
          color: estados.contains(WidgetState.selected)
              ? cores.onPrimary
              : cores.onPrimaryContainer,
        ),
      ),
    ),
  );
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  bool escuro = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: criarTema(Brightness.light),
      darkTheme: criarTema(Brightness.dark),
      themeMode: escuro ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(
        escuro: escuro,
        aoAlternarTema: () {
          setState(() {
            escuro = !escuro;
          });
        },
      ),
    );
  }
}

/// Estrutura principal do aplicativo: AppBar, telas e menu inferior.
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.escuro,
    required this.aoAlternarTema,
  });

  final bool escuro;
  final VoidCallback aoAlternarTema;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indice = 0;
  final List<String> favoritos = [...favoritosIniciais];

  final titulos = const ['Início', 'Cursos', 'Favoritos', 'Perfil'];

  /// Adiciona ou remove o curso dos favoritos.
  void _alternarFavorito(String nome) {
    setState(() {
      if (favoritos.contains(nome)) {
        favoritos.remove(nome);
      } else {
        favoritos.add(nome);
      }
    });
  }

  void _abrirCurso(Curso curso) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Abrindo o curso ${curso.nome}...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final telas = [
      const InicioTela(),
      CursosTela(
        favoritos: favoritos,
        aoFavoritar: _alternarFavorito,
        aoAbrir: _abrirCurso,
      ),
      FavoritosTela(
        favoritos: favoritos,
        aoFavoritar: _alternarFavorito,
        aoAbrir: _abrirCurso,
      ),
      PerfilTela(
        escuro: widget.escuro,
        aoAlternarTema: widget.aoAlternarTema,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(titulos[indice])),
      body: telas[indice],
      bottomNavigationBar: NavigationBar(
        selectedIndex: indice,
        onDestinationSelected: (valor) {
          setState(() {
            indice = valor;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Cursos',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            selectedIcon: Icon(Icons.person_2),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
