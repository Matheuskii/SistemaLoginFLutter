import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_flutter/app.dart';
import 'package:instagram_flutter/models/reel.dart';
import 'package:instagram_flutter/pages/buscar_page.dart';
import 'package:instagram_flutter/pages/feed_page.dart';
import 'package:instagram_flutter/pages/perfil_page.dart';
import 'package:instagram_flutter/pages/reels_page.dart';
import 'package:instagram_flutter/widgets/post_instagram.dart';

Widget montarTela(Widget tela) {
  return MaterialApp(home: Scaffold(body: tela));
}

Future<void> rolarParaProximoReel(WidgetTester tester) async {
  await tester.drag(find.byType(PageView), const Offset(0, -600));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

void main() {
  testWidgets('Home navega entre as abas do menu inferior', (tester) async {
    await tester.pumpWidget(const InstagramApp());

    expect(find.text('Seu story'), findsOneWidget);
    expect(find.text('seguidores'), findsNothing);

    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();

    expect(find.text('seu.usuario'), findsOneWidget);
    expect(find.text('seguidores'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.movie_outlined));
    await tester.pumpAndSettle();

    expect(find.text('@flutter.dev'), findsOneWidget);
  });

  testWidgets('Feed mostra stories e publicacoes', (tester) async {
    await tester.pumpWidget(montarTela(const FeedPage()));

    expect(find.text('InstaAula'), findsOneWidget);
    expect(find.text('Seu story'), findsOneWidget);
    expect(find.text('128 curtidas'), findsOneWidget);

    await tester.drag(find.byType(CustomScrollView), const Offset(0, -700));
    await tester.pumpAndSettle();

    expect(find.text('professor.mobile'), findsOneWidget);
  });

  testWidgets('PostInstagram alterna curtida e salvamento', (tester) async {
    await tester.pumpWidget(montarTela(
      const PostInstagram(
        usuario: 'flutter.dev',
        local: 'Sao Paulo, Brasil',
        legenda: 'Testando o post',
        cor: Colors.blue,
        icone: Icons.flutter_dash,
        curtidasInciais: 10,
      )
    ));

    expect(find.text('10 curtidas'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(find.text('11 curtidas'), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    await tester.tap(find.byIcon(Icons.bookmark_border));
    await tester.pump();

    expect(find.byIcon(Icons.bookmark), findsOneWidget);
  });

  testWidgets('Buscar filtra os assuntos digitados', (tester) async {
    await tester.pumpWidget(montarTela(const BuscarPage()));

    expect(find.text('Flutter'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'dart');
    await tester.pumpAndSettle();

    expect(find.text('Dart'), findsOneWidget);
    expect(find.text('Flutter'), findsNothing);

    await tester.enterText(find.byType(TextField), 'nao existe');
    await tester.pumpAndSettle();

    expect(find.text('Nenhum resultado para "nao existe"'), findsOneWidget);
  });

  testWidgets('Perfil mostra estatisticas e publicacoes', (tester) async {
    await tester.pumpWidget(montarTela(const PerfilPage()));

    expect(find.text('seu.usuario'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
    expect(find.text('publicações'), findsOneWidget);
    expect(find.text('seguidores'), findsOneWidget);
    expect(find.text('seguindo'), findsOneWidget);
    expect(find.text('Aluno de Flutter'), findsOneWidget);
    expect(find.text('Editar perfil'), findsOneWidget);
    expect(find.text('Compartilhar perfil'), findsOneWidget);
    expect(find.byIcon(Icons.flutter_dash), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();

    expect(find.text('Opções da conta'), findsOneWidget);
  });

  testWidgets('Reels mostra os botoes de interacao', (tester) async {
    await tester.pumpWidget(montarTela(const ReelsPage()));

    expect(find.text('@flutter.dev'), findsOneWidget);
    expect(find.text('2,5 mil'), findsOneWidget);
    expect(find.text('Compartilhar'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    expect(find.text('Você compartilhou'), findsOneWidget);
  });

  testWidgets('Reels carrega mais reels ao chegar no fim da lista', (tester) async {
    await tester.pumpWidget(montarTela(const ReelsPage()));

    expect(find.text(modelosDeReels[0].usuario), findsOneWidget);

    await rolarParaProximoReel(tester);
    await rolarParaProximoReel(tester);

    expect(find.text(modelosDeReels[2].usuario), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.drag(find.byType(PageView), const Offset(0, -600));
    await tester.pump();

    expect(find.text('Carregando mais reels...'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 900));

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text(modelosDeReels[3].usuario), findsOneWidget);
  });

}
