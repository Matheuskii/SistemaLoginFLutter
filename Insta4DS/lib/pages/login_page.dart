import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_flutter/pages/cadastro_page.dart';
import 'package:instagram_flutter/pages/home_page.dart';
import 'package:instagram_flutter/pages/recuperar_senha_page.dart';
import 'package:instagram_flutter/services/usuario_repositorio.dart';
import 'package:instagram_flutter/utils/mensagem_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureSenha = true;
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _entrar() {
    if (!_formKey.currentState!.validate()) return;

    final identificador = _emailController.text.trim();
    final senha = _senhaController.text;

    final erro = UsuarioRepositorio.instancia.login(identificador, senha);

    if (erro != null) {
      mostrarMensagem(context, erro);
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60.0),

                Center(
                  child: SvgPicture.asset(
                    'assets/images/instagram-1.svg',
                    height: 60.0,
                  ),
                ),

                const SizedBox(height: 67.0),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFAFAFA),
                    label: const Text('Telefone, usuário ou email'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Color(0xFFDBDBDB)),
                    ),
                  ),
                  validator: (valor) => (valor == null || valor.trim().isEmpty)
                      ? 'Informe seu usuário ou e-mail'
                      : null,
                ),

                const SizedBox(height: 20.0),

                TextFormField(
                  controller: _senhaController,
                  obscureText: _obscureSenha,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFAFAFA),
                    label: const Text('Senha'),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Color(0xFFDBDBDB)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureSenha
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => _obscureSenha = !_obscureSenha);
                      },
                    ),
                  ),
                  validator: (valor) => (valor == null || valor.isEmpty)
                      ? 'Informe sua senha'
                      : null,
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const RecuperarSenhaPage(),
                        ),
                      );
                    },
                    child: const Text('Esqueceu a senha?'),
                  ),
                ),

                const SizedBox(height: 12),

                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF0095F6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                  onPressed: _entrar,
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 24.0),

                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'OU',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24.0),

                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook, color: Colors.blue),
                    label: const Text(
                      'Entrar com o Facebook',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40.0),

                const Divider(),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Não tem uma conta?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CadastroPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Cadastre-se',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
