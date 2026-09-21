import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/reel.dart';
import 'package:instagram_flutter/widgets/card_reel.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {

  /// Quantidade de reels buscada em cada página da lista.
  static const int reelsPorPagina = 3;

  /// Tempo que uma busca no servidor levaria para devolver mais reels.
  static const Duration tempoDeBusca = Duration(milliseconds: 800);

  final PageController controladorDePaginas = PageController();

  /// Reels já carregados: a primeira página já começa pronta na tela.
  final List<Reel> reels = gerarPaginaDeReels(0, reelsPorPagina);

  int paginaAtual = 0;
  bool carregando = false;

  @override
  void dispose() {
    controladorDePaginas.dispose();
    super.dispose();
  }

  /// Busca a próxima página de reels e adiciona no fim da lista.
  Future<void> carregarMaisReels() async {
    // Evita buscar a mesma página duas vezes enquanto a busca está em andamento.
    if (carregando) {
      return;
    }
    setState(() {
      carregando = true;
    });

    // Aqui entraria a chamada de uma API. O delay abaixo simula essa espera.
    await Future.delayed(tempoDeBusca);
    if (!mounted) {
      return;
    }

    setState(() {
      paginaAtual++;
      reels.addAll(gerarPaginaDeReels(paginaAtual, reelsPorPagina));
      carregando = false;
    });
  }

  /// Chamado sempre que o reel no centro da tela muda.
  void aoMudarDeReel(int indice){
    // A última posição da lista é o indicador de carregamento, por isso o
    // último reel carregado é o penúltimo item. Ao chegar nele já buscamos mais.
    if (indice >= reels.length - 1) {
      carregarMaisReels();
    }
  }

  Widget indicadorDeCarregamento(){
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 12,),
          Text(
            'Carregando mais reels...',
            style: TextStyle(color: Colors.white70)
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: controladorDePaginas,
          scrollDirection: Axis.vertical,
          // Uma posição a mais no fim da lista para o indicador de carregamento.
          itemCount: reels.length + 1,
          onPageChanged: aoMudarDeReel,
          itemBuilder: (context, indice){
            if (indice >= reels.length) {
              return indicadorDeCarregamento();
            }
            return CardReel(reel: reels[indice]);
          },
        ),
        Positioned(
          top: 0,
          left: 0,
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Reels',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
