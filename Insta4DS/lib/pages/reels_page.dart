import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/reel.dart';
import 'package:instagram_flutter/widgets/card_reel.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {

  static const int reelsPorPagina = 3;

  static const Duration tempoDeBusca = Duration(milliseconds: 800);

  final PageController controladorDePaginas = PageController();

  final List<Reel> reels = gerarPaginaDeReels(0, reelsPorPagina);

  int paginaAtual = 0;
  bool carregando = false;

  @override
  void dispose() {
    controladorDePaginas.dispose();
    super.dispose();
  }

  Future<void> carregarMaisReels() async {
    if (carregando) {
      return;
    }
    setState(() {
      carregando = true;
    });

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

  void aoMudarDeReel(int indice){
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
