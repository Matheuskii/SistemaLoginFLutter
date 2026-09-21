# Insta4DS

Clone simplificado do Instagram feito em Flutter nas aulas de desenvolvimento mobile.

## Telas

- **Feed** (`lib/pages/feed_page.dart`): stories e publicações com curtir, comentar, compartilhar e salvar.
- **Buscar** (`lib/pages/buscar_page.dart`): campo de pesquisa que filtra os assuntos em grade.
- **Reels** (`lib/pages/reels_page.dart`): reels em tela cheia (`PageView` vertical) com botões de interação e scroll infinito, carregando mais reels quando o usuário chega no fim da lista.
- **Perfil** (`lib/pages/perfil_page.dart`): nome, bio, estatísticas e grade de publicações.

A navegação entre as telas fica em `lib/pages/home_page.dart` usando `NavigationBar` + `IndexedStack`.

## Widgets

`PostInstagram`, `Stories`, `BotaoReels`, `CardReel` e `NumeroPerfil` ficam em `lib/widgets`.
Os dados de cada reel vêm do modelo `Reel` de `lib/models/reel.dart`, que também gera as páginas carregadas pelo scroll infinito.
As mensagens rápidas de interação usam o helper `mostrarMensagem` de `lib/utils/mensagem_util.dart`.

## Como rodar

```
flutter pub get
flutter run
```

## Testes

```
flutter test
```
