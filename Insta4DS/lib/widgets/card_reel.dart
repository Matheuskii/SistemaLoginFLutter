import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/reel.dart';
import 'package:instagram_flutter/utils/mensagem_util.dart';
import 'package:instagram_flutter/widgets/botao_reels.dart';

/// Mostra um reel ocupando a tela inteira, com os botões de interação.
class CardReel extends StatelessWidget {
  final Reel reel;

  const CardReel({required this.reel, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [reel.cor, Colors.black],
              begin: AlignmentGeometry.topCenter,
            ),
          ),
          child: Icon(reel.icone, color: Colors.white54, size: 110),
        ),
        Positioned(
          left: 16,
          right: 90,
          bottom: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reel.usuario,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 8,),
              Text(
                reel.descricao,
                style: TextStyle(
                  color: Colors.white
                ),
              )
            ],
          ),
        ),
        Positioned(
          right: 12,
          bottom: 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BotaoReels(
                icone: Icons.favorite_border,
                texto: reel.curtidas,
                aoTocar: (){
                  mostrarMensagem(context, 'Você curtiu');
                }
              ),
              BotaoReels(
                icone: Icons.mode_comment_outlined,
                texto: reel.comentarios,
                aoTocar: (){
                  mostrarMensagem(context, 'Você comentou');
                }
              ),
              BotaoReels(
                icone: Icons.send,
                texto: 'Compartilhar',
                aoTocar: (){
                  mostrarMensagem(context, 'Você compartilhou');
                }
              ),
            ],
          )
        ),
      ],
    );
  }
}
