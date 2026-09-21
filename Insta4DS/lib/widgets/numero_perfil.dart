import 'package:flutter/material.dart';

class NumeroPerfil extends StatelessWidget {
  final String numero;
  final String rotulo;

  const NumeroPerfil({super.key, required this.numero, required this.rotulo});

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          numero,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold
          )
        ),
        Text(
          rotulo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey
          )
        ),
      ],
    );
  }
}
