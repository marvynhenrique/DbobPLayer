# DBob Player

Projeto oficial do **DBob Player**.

> Use apenas com servidores, listas e conteúdos que você tenha autorização para acessar, distribuir e reproduzir.

## Sprint 05 — Teste Completo Core

Esta versão remove os mocks antigos e entrega um app mais completo para teste real.

### Funcionalidades

- Login real via Xtream.
- Modo Login e Senha com servidores internos.
- Modo Xtream Codes manual.
- Múltiplas contas/listas cadastradas no app.
- Alternar conta/lista.
- Deletar conta/lista.
- Abrir sempre na última conta ativa.
- Sair da conta.
- Sair do aplicativo.
- Home com recomendações com imagem e título.
- Clique em recomendação abre página de sinopse/detalhes.
- TV Ao Vivo.
- Filmes.
- Séries.
- Página de sinopse/detalhes.
- Episódios de séries.
- Player de vídeo básico.
- Favoritos por conta.
- Histórico por conta.
- Busca local dentro da categoria carregada.
- Botão de atualizar catálogo.
- Permissão de internet e HTTP no Android.

### Ainda pendente para próxima fase

- Chromecast/Cast.
- Downloads offline.
- EPG/guia de programação.
- Player avançado com áudio, legenda, qualidade e PiP.
- DNS remota/oculta com assinatura.
- Criptografia das credenciais locais.

## Como aplicar no GitHub

1. Extraia o ZIP.
2. Entre na pasta `DBobPlayer-Sprint05-TesteCompletoCore`.
3. Envie o conteúdo para a raiz do repositório `DbobPLayer`.

Recomendado: antes de subir, delete arquivos Dart antigos soltos na raiz do repositório, como:

```text
main.dart
home_screen.dart
catalog_screen.dart
settings_screen.dart
widget_test.dart
```

Eles não fazem parte da estrutura correta. A estrutura correta é dentro da pasta `lib/`.

Depois faça commit:

```bash
git add .
git commit -m "Sprint 05: teste completo core do app"
git push
```

Depois rode:

```text
Actions > Build Android APK > Run workflow
```
