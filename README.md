# DBob Player

Projeto oficial do **DBob Player**, organizado para desenvolvimento Flutter com build automático de APK pelo GitHub Actions.

> Uso recomendado apenas com servidores, listas e conteúdos que você tenha autorização para acessar, distribuir e reproduzir.

## Sprint 01 — Foundation

Esta entrega cria a fundação do projeto:

- Base Flutter oficial gerada por `flutter create`.
- Arquitetura inicial em camadas.
- Tema escuro premium.
- Telas iniciais navegáveis.
- Configuração interna de servidores.
- GitHub Actions para gerar APK automaticamente.
- Scripts CMD para build local no Windows.

## Estrutura

```text
.github/workflows/
assets/config/
docs/
lib/src/
scripts/
test/
```

## Como usar no GitHub

1. Extraia este ZIP.
2. Copie tudo para dentro do repositório `marvynhenrique/DbobPLayer`.
3. Faça commit e push.

```bash
git add .
git commit -m "Sprint 01: foundation do DBob Player"
git push
```

Após o push, vá em:

```text
GitHub > Actions > Build Android APK > Artifacts
```

Baixe o APK gerado.

## Build local pelo CMD

No Windows, com Flutter e Android SDK instalados:

```bat
scripts\BUILD_DBOB_PLAYER.cmd
```

O APK será copiado para:

```text
OUTPUT\DBob_Player_v0.1.0_release.apk
```

## Próxima sprint

**Sprint 02 — Login, servidores e persistência**

- Persistência local real.
- Leitura dos servidores internos.
- Login e senha procurando servidor automaticamente.
- Xtream Codes com URL + usuário + senha.
- Estrutura inicial do Xtream Service.
