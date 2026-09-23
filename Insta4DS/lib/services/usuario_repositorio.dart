import 'package:instagram_flutter/models/usuario.dart';

class UsuarioRepositorio {
  UsuarioRepositorio._();
  static final UsuarioRepositorio instancia = UsuarioRepositorio._();

  Usuario? _usuarioCadastrado;
  Usuario? usuarioLogado;

  void cadastrar(Usuario usuario) {
    _usuarioCadastrado = usuario;
  }

  String? login(String identificador, String senha) {
    if (_usuarioCadastrado == null) {
      return 'Nenhum usuário cadastrado. Cadastre-se primeiro.';
    }
    final usuario = _usuarioCadastrado!;
    final identificadorValido =
        identificador == usuario.email || identificador == usuario.usuario;

    if (!identificadorValido || senha != usuario.senha) {
      return 'E-mail/usuário ou senha inválidos.';
    }

    usuarioLogado = usuario;
    return null;
  }

  void logout() {
    usuarioLogado = null;
  }

  void atualizarPerfil({
    required String nome,
    required String usuario,
    required String biografia,
  }) {
    usuarioLogado?.nome = nome;
    usuarioLogado?.usuario = usuario;
    usuarioLogado?.biografia = biografia;
  }
}
