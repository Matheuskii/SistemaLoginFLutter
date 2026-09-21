import 'package:flutter/material.dart';

/// Tela com o formulário de edição do perfil do estudante.
class EditarPerfilTela extends StatefulWidget {
  const EditarPerfilTela({super.key});

  @override
  State<EditarPerfilTela> createState() => _EditarPerfilTelaState();
}

class _EditarPerfilTelaState extends State<EditarPerfilTela> {
  final nomeController = TextEditingController(text: 'Estudante de Flutter');
  final emailController = TextEditingController(text: 'estudante@email.com');

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _salvar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Perfil de ${nomeController.text} salvo com sucesso!'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar perfil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nomeController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Nome',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'E-mail',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _salvar,
              icon: const Icon(Icons.save),
              label: const Text('Salvar'),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Nesta atividade os dados não são salvos permanentemente.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
