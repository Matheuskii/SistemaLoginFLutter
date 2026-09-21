import 'package:flutter/material.dart';

class BotaoReels extends StatelessWidget {
  final IconData icone;
  final String texto;
  final VoidCallback aoTocar;

  const BotaoReels({required this.icone, required this.texto, required this.aoTocar, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          IconButton(
            onPressed: aoTocar,
            icon: Icon(icone, color: Colors.white, size: 30,)
          ),
          Text(
            texto,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12
            ),
          )
        ],
      ),
    );
  }
}