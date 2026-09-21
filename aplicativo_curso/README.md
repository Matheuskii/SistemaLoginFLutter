# aplicativo_curso

Aplicativo de cursos desenvolvido nas aulas de Flutter. O projeto foi evoluído
a partir do app da aula, com o código organizado em pastas e novas
funcionalidades.

## Estrutura do projeto

```
lib/
  main.dart                        -> inicialização, tema e menu inferior
  modelos/
    curso.dart                     -> modelo Curso e a lista de cursos
  telas/
    inicio_tela.dart               -> curso em andamento, cursos disponíveis e resumo
    cursos_tela.dart               -> lista de cursos com pesquisa e favoritos
    favoritos_tela.dart            -> cursos marcados como favoritos
    perfil_tela.dart               -> dados do estudante e opções extras
    editar_perfil_tela.dart        -> formulário de edição do perfil
  widgets/
    curso_card.dart                -> Card reutilizável de curso
```

## Funcionalidades

- Menu inferior com Início, Cursos, Favoritos e Perfil.
- Pesquisa de cursos com `TextField` e `setState`.
- Favoritar e desfavoritar cursos com `IconButton` (inicia com três favoritos).
- Lista com seis cursos, cada um com nome, descrição, quantidade de aulas,
  ícone e botão "Continuar curso".
- Tela inicial com três seções e barra de progresso (`LinearProgressIndicator`,
  8 de 12 aulas concluídas).
- Tela de perfil com foto, nome, e-mail, curso atual e resumo, além do botão
  "Editar perfil" que abre o formulário (`Navigator.push`).
- Personalização: tema claro/escuro com cor principal roxa, AppBar colorida,
  cards arredondados com sombra e menu inferior personalizado.
- Funcionalidades extras: modo escuro e a janela "Sobre o aplicativo".

## Como executar

```bash
flutter pub get
flutter run
flutter analyze
flutter test
```
