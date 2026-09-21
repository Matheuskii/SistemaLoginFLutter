import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_login/pages/login_page.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  final String nomeUsuario;
  final String emailUsuario;
  const HomePage({
    super.key,
    required this.nomeUsuario,
    required this.emailUsuario,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
   late String nomeController;
  late String emailController;



  @override
  void initState() {
    super.initState();
    carregarPerfil();

    nomeController = widget.nomeUsuario;
    emailController = widget.emailUsuario;
  }

  final ImagePicker picker = ImagePicker();

  File? fotoPerfil;

  Future<void> escolherDaGaleria() async {
    final XFile? imagem = await picker.pickImage(source: ImageSource.gallery);

    if (imagem == null) {
      return;
    }
    setState(() {
      fotoPerfil = File(imagem.path);
    });
  }

  Future<void> tirarFoto() async {
    final XFile? imagem = await picker.pickImage(source: ImageSource.camera);

    if (imagem == null) {
      return;
    }
    setState(() {
      fotoPerfil = File(imagem.path);
    });
  }

  void mostrarOpcoesFoto() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
                onTap: () {
                  Navigator.pop(context);
                  escolherDaGaleria();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Câmera'),
                onTap: () {
                  Navigator.pop(context);
                  tirarFoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<File> guardarFoto(File foto) async {
    final pasta = await getApplicationDocumentsDirectory();
    final caminho = '${pasta.path}/foto-perfil.jpg';
    return foto.copy(caminho);
  }

  Future<void> salvarPerfil() async {
    final nome = nomeController;
    final email = emailController;

    if (nome.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o nome e o e-mail')),
      );

      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('nome', nome);
    await prefs.setString('email', email);

    if (fotoPerfil != null) {
      final fotoSalva = await guardarFoto(fotoPerfil!);

      await prefs.setString('foto', fotoSalva.path);

      if (mounted) {
        setState(() {
          fotoPerfil = fotoSalva;
        });
      }
      if (!context.mounted) {
        return;
      }
    }

    ScaffoldMessenger.of(
      
      context,
    ).showSnackBar(const SnackBar(content: Text('Perfil salvo com sucesso')));
  }

  Future<void> carregarPerfil() async {
    final prefs = await SharedPreferences.getInstance();

    final nome = prefs.getString('nome');
    final email = prefs.getString('email');
    final caminhoFoto = prefs.getString('foto');

    nomeController = nome ?? '';
    emailController = email ?? '';

    if (caminhoFoto != null) {
      final arquivo = File(caminhoFoto);

      if (await arquivo.exists()) {
        setState(() {
          fotoPerfil = arquivo;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    sair(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

    return Scaffold(
      appBar: AppBar(title: const Text('Sistema'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: fotoPerfil != null
                  ? FileImage(fotoPerfil!)
                  : null,
              child: fotoPerfil == null
                  ? const Icon(Icons.person, size: 70)
                  : null,
            ),

            const Icon(Icons.home, size: 100),
            const SizedBox(height: 20),

            const Text(
              'Bem-vindo ao sistema!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            Text(
              widget.nomeUsuario,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Text(
              widget.emailUsuario,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: mostrarOpcoesFoto,
              icon: Icon(Icons.camera_alt, color: Colors.black),
              label: Text(
                'Alterar foto',
                style: TextStyle(color: Colors.black),
              ),
            ),

            ElevatedButton.icon(
              onPressed: sair(context),
              icon: const Icon(Icons.logout),
              label: const Text("Sair"),
            ),
          ],
        ),
      ),
    );
  }
}
