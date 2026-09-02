import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
    const HomePage({super.key});

    @override
    State<HomePage> createState () => _HomePageState();
}

class _HomePageState extends State<HomePage>{
    int indice = 0;

    final telas = const [
      InicioTela(),
      CursosTela(),
      PerfilTela()
    ];

    final titulos = const [
      'Início',
      'Meus cursos',
      'Meu perfil'
    ];

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text(titulos[indice]),
          centerTitle: true,
        ),
        body: telas[indice],

        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (valor){
              setState(() {
                indice = valor;
              });
          },
          selectedIndex: indice,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined), 
              label: 'Início'
            ),
            NavigationDestination(
              icon: Icon(Icons.school_outlined), 
              label: 'Cursos'
            ),
            NavigationDestination(
              icon: Icon(Icons.person_2_outlined), 
              label: 'Perfil'
            ),
          ],
        ),
      );
    }
}


class InicioTela extends StatelessWidget{
    const InicioTela({super.key});

    @override
    Widget build(BuildContext context) {
      return ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Olá, estudante!',
            style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(fontWeight: FontWeight.bold,
            )
          ),

          const SizedBox(height: 8,),

          const Text(
            'Continue aprendendo e evoluindo.'
          ),

          const SizedBox(height: 24,),

          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient( 
                colors: [
                  Colors.deepPurple,
                  Colors.purpleAccent,
                ]
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5)
                )
              ]
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.flutter_dash,
                  color: Colors.white,
                  size: 46,
                ),
                Text(
                  'Flutter Básico',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '8 de 12 aulas concluídas',
                   style: TextStyle(
                    color: Colors.white,
                  )
                )
              ],
            ),
          ),
        ],  
      );
    }
}

class CursosTela extends StatelessWidget{
    const CursosTela({super.key});

    

    @override
    Widget build(BuildContext context) {
      return const Center(
        child: Text("Tela curso"),
      );
    }
}
class PerfilTela extends StatelessWidget{
    const PerfilTela({super.key});

    @override
    Widget build(BuildContext context) {
      return const Center(
        child: Text("Tela curso"),
      );
    }
}