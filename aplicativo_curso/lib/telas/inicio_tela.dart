import 'package:flutter/material.dart';

import '../modelos/curso.dart';

/// Tela inicial com o curso em andamento, cursos disponíveis e o resumo do estudante.
class InicioTela extends StatelessWidget {
  const InicioTela({super.key});

  @override
  Widget build(BuildContext context) {
    final destaques = cursos.take(3).toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Olá, estudante!',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Continue aprendendo e evoluindo.'),

        // ---- Seção 1: curso em andamento ----
        const SizedBox(height: 24),
        const _TituloSecao('Curso em andamento'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF4527A0), Color(0xFF7C4DFF)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.flutter_dash, color: Colors.white, size: 46),
              const SizedBox(height: 8),
              const Text(
                'Flutter Básico',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                '8 de 12 aulas concluídas',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(
                  value: 8 / 12,
                  minHeight: 8,
                  backgroundColor: Colors.white30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Continuando o curso Flutter Básico!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF4527A0),
                  ),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Continuar'),
                ),
              ),
            ],
          ),
        ),

        // ---- Seção 2: cursos disponíveis ----
        const SizedBox(height: 12),
        const _TituloSecao('Cursos disponíveis'),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              for (final curso in destaques)
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(curso.icone),
                  ),
                  title: Text(curso.nome),
                  subtitle: Text('${curso.aulas} aulas'),
                  trailing: const Icon(Icons.chevron_right),
                ),
            ],
          ),
        ),

        // ---- Seção 3: resumo do estudante ----
        const SizedBox(height: 12),
        const _TituloSecao('Resumo do estudante'),
        const SizedBox(height: 12),
        const Row(
          children: [
            _ResumoItem(valor: '4', texto: 'Cursos iniciados'),
            SizedBox(width: 12),
            _ResumoItem(valor: '1', texto: 'Cursos concluídos'),
            SizedBox(width: 12),
            _ResumoItem(valor: '18', texto: 'Aulas concluídas'),
          ],
        ),
      ],
    );
  }
}

/// Título usado nas seções da tela inicial.
class _TituloSecao extends StatelessWidget {
  const _TituloSecao(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

/// Item do resumo do estudante (número e descrição).
class _ResumoItem extends StatelessWidget {
  const _ResumoItem({required this.valor, required this.texto});

  final String valor;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Text(
                valor,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                texto,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
