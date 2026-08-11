import 'package:flutter/material.dart';
import 'package:sistema_login/pages/home_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de login',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const LoginPage(),
    );
  }
}
