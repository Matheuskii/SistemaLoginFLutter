import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/mensagem_util.dart';
import 'package:instagram_flutter/widgets/numero_perfil.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  static const String usuario = 'seu.usuario';
  static const String nome = 'Aluno de Flutter';
  static const String biografia = 'Aprendendo Flutter na aula de desenvolvimento mobile 💓';

  static const List<(IconData, Color)> publicacoes = [
    (Icons.flutter_dash, Colors.blue),
    (Icons.school, Colors.deepPurple),
    (Icons.code, Colors.teal),
    (Icons.phone_android, Colors.orange),
    (Icons.brush, Colors.pink),
    (Icons.terminal, Colors.indigo),
    (Icons.storage, Colors.green),
    (Icons.design_services, Colors.red),
    (Icons.auto_awesome, Colors.amber),
  ];

  Widget cabecalho(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 42,
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.person, color: Colors.white, size: 48),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: NumeroPerfil(
                  numero: '${publicacoes.length}',
                  rotulo: 'publicações'
                )
              ),
              const Expanded(
                child: NumeroPerfil(
                  numero: '128',
                  rotulo: 'seguidores'
                )
              ),
              const Expanded(
                child: NumeroPerfil(
                  numero: '67',
                  rotulo: 'seguindo'
                )
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            nome,
            style: TextStyle(
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 4),
          const Text(biografia),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    mostrarMensagem(context, 'Editar perfil');
                  },
                  child: const Text('Editar perfil')
                )
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    mostrarMensagem(context, 'Compartilhar perfil');
                  },
                  child: const Text('Compartilhar perfil')
                )
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.white,
            title: const Text(
              usuario,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold
              )
            ),
            actions: [
              IconButton(
                onPressed: () {
                  mostrarMensagem(context, 'Opções da conta');
                },
                icon: const Icon(Icons.menu)
              ),
            ],
          ),
          SliverToBoxAdapter(child: cabecalho(context)),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, indice) {
                final publicacao = publicacoes[indice];

                return GestureDetector(
                  onTap: () {
                    mostrarMensagem(context, 'Abrir publicação ${indice + 1}');
                  },
                  child: Container(
                    color: publicacao.$2,
                    child: Icon(publicacao.$1, color: Colors.white, size: 38),
                  ),
                );
              },
              childCount: publicacoes.length,
            ),
          ),
        ],
      ),
    );
  }
}
