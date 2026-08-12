import 'package:flutter/material.dart';
import 'package:sistema_login/dados_mock.dart';
import 'package:sistema_login/pages/cadastro_page.dart';
import 'package:sistema_login/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool esconderSenha = true;

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  void abrirCadastro() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CadastroPage()),
    );
  }

  void entrar() {
    String email = emailController.text.trim();
    String senha = senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      mostrarMensagem('Preencha o e-mail e a senha');
      return;
    }

    Map<String, String>? usuarioEncontrado;

    for (var usuario in usuarios) {
      if (usuario['email'] == email && usuario['senha'] == senha) {
        mostrarMensagem("Login realizado com sucesso");
        usuarioEncontrado = usuario;
        break;
      }

      if (usuarioEncontrado == null) {
        mostrarMensagem("mensagem");
        return;
      }
    }

    String nome = usuarioEncontrado?['nome'] ?? 'usuário';

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(nomeUsuario: nome, emailUsuario: email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),

            const Icon(Icons.account_circle, size: 100),

            const SizedBox(height: 20),

            const Text(
              'Seja bem vindo!!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              'Entre com a sua conta para acessar o sistema',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Digite seu e-mail',
                prefixIcon: const Icon(Icons.email),
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: senhaController,
              keyboardType: TextInputType.emailAddress,
              obscureText: esconderSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                prefixIcon: const Icon(Icons.password),
                border: const OutlineInputBorder(),

                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      esconderSenha = !esconderSenha;
                    });
                  },
                  icon: Icon(
                    esconderSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: () {
                entrar();
              },
              icon: Icon(Icons.login),
              label: const Text('Entrar'),
            ),
            const SizedBox(height: 25),
            OutlinedButton.icon(
              onPressed: abrirCadastro,
              label: const Text('Criar Usuário'),
            ),
          ],
        ),
      ),
    );
  }
}
