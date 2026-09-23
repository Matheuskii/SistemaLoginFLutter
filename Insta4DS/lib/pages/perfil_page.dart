import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_flutter/pages/login_page.dart';
import 'package:instagram_flutter/services/usuario_repositorio.dart';
import 'package:instagram_flutter/utils/mensagem_util.dart';
import 'package:instagram_flutter/widgets/numero_perfil.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
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

  void _sair() {
    UsuarioRepositorio.instancia.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  Future<void> _editarPerfil() async {
    final usuario = UsuarioRepositorio.instancia.usuarioLogado;
    if (usuario == null) return;

    final formKey = GlobalKey<FormState>();
    final nomeController = TextEditingController(text: usuario.nome);
    final usuarioController = TextEditingController(text: usuario.usuario);
    final bioController = TextEditingController(text: usuario.biografia);

    final salvou = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Editar perfil'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nomeController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (valor) =>
                        (valor == null || valor.trim().isEmpty)
                            ? 'Informe o nome'
                            : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: usuarioController,
                    decoration:
                        const InputDecoration(labelText: 'Nome de usuário'),
                    validator: (valor) =>
                        (valor == null || valor.trim().isEmpty)
                            ? 'Informe o nome de usuário'
                            : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: bioController,
                    decoration: const InputDecoration(labelText: 'Biografia'),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (salvou == true) {
      UsuarioRepositorio.instancia.atualizarPerfil(
        nome: nomeController.text.trim(),
        usuario: usuarioController.text.trim(),
        biografia: bioController.text.trim(),
      );
      setState(() {});
      if (mounted) mostrarMensagem(context, 'Dados atualizados');
    }
  }

  Widget cabecalho(BuildContext context, usuario) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 42,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: SizedBox(
                    width: 84,
                    height: 84,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SvgPicture.asset('assets/images/avatar-padrao.svg'),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: NumeroPerfil(
                  numero: '${publicacoes.length}',
                  rotulo: 'publicações',
                ),
              ),
              const Expanded(
                child: NumeroPerfil(numero: '128', rotulo: 'seguidores'),
              ),
              const Expanded(
                child: NumeroPerfil(numero: '67', rotulo: 'seguindo'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            usuario?.nome ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(usuario?.biografia ?? ''),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _editarPerfil,
                  child: const Text('Editar perfil'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    mostrarMensagem(context, 'Compartilhar perfil');
                  },
                  child: const Text('Compartilhar perfil'),
                ),
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
    final usuario = UsuarioRepositorio.instancia.usuarioLogado;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.white,
            title: Text(
              usuario?.usuario ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: _sair,
                icon: const Icon(Icons.logout),
                tooltip: 'Sair',
              ),
            ],
          ),
          SliverToBoxAdapter(child: cabecalho(context, usuario)),
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
