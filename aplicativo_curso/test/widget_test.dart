// Testes básicos do aplicativo de cursos.
// Executar com: flutter test

import 'package:aplicativo_curso/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Aumenta a tela do teste para que todo o conteúdo caiba sem rolagem.
void usarTelaGrande(WidgetTester tester) {
  tester.view.physicalSize = const Size(1800, 3600);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('Mostra a tela de início com o resumo do estudante',
      (WidgetTester tester) async {
    usarTelaGrande(tester);
    await tester.pumpWidget(const MeuApp());

    expect(find.text('Olá, estudante!'), findsOneWidget);
    expect(find.text('Curso em andamento'), findsOneWidget);
    expect(find.text('8 de 12 aulas concluídas'), findsOneWidget);
    expect(find.text('Resumo do estudante'), findsOneWidget);
    expect(find.text('Aulas concluídas'), findsOneWidget);
  });

  testWidgets('Pesquisa cursos na tela de cursos', (WidgetTester tester) async {
    usarTelaGrande(tester);
    await tester.pumpWidget(const MeuApp());

    await tester.tap(find.text('Cursos'));
    await tester.pumpAndSettle();

    expect(find.text('Pesquisar curso'), findsOneWidget);
    expect(find.text('Flutter Básico'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Dart');
    await tester.pumpAndSettle();

    expect(find.text('Dart Essencial'), findsOneWidget);
    expect(find.text('Flutter Básico'), findsNothing);
  });

  testWidgets('Favorita um curso', (WidgetTester tester) async {
    usarTelaGrande(tester);
    await tester.pumpWidget(const MeuApp());

    await tester.tap(find.text('Cursos'));
    await tester.pumpAndSettle();

    // Dart Essencial é o primeiro curso que ainda não está favoritado.
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Favoritos'));
    await tester.pumpAndSettle();

    expect(find.text('Flutter Básico'), findsOneWidget);
    expect(find.text('Dart Essencial'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsAtLeastNWidgets(4));
  });

  testWidgets('Perfil abre a tela de edição e ativa o modo escuro',
      (WidgetTester tester) async {
    usarTelaGrande(tester);
    await tester.pumpWidget(const MeuApp());

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Editar perfil'));
    await tester.tap(find.text('Editar perfil'));
    await tester.pumpAndSettle();

    expect(find.text('Salvar'), findsOneWidget);

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Editar perfil'), findsOneWidget);

    // Funcionalidade extra: modo escuro.
    await tester.ensureVisible(find.text('Modo escuro'));
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
        isTrue);
  });
}
