# DBob Player

Projeto oficial do **DBob Player**, organizado para desenvolvimento Flutter com build automático de APK pelo GitHub Actions.

> Uso recomendado apenas com servidores, listas e conteúdos que você tenha autorização para acessar, distribuir e reproduzir.

## Sprint 02 — Xtream Core

Esta atualização transforma a base da Sprint 01 em um app funcional de conexão e catálogo:

- Login e Senha testando servidores internos por prioridade.
- Xtream Codes com URL + usuário + senha.
- Validação real via `player_api.php`.
- Sessão local com `shared_preferences`.
- Carregamento de categorias:
  - TV Ao Vivo
  - Filmes
  - Séries
- Listagem inicial de conteúdos por categoria.
- Botão de sair da sessão.
- Botão de atualizar catálogo.

## Como subir no GitHub

Copie o conteúdo desta pasta para a raiz do repositório `DbobPLayer`.

Depois faça commit:

```bash
git add .
git commit -m "Sprint 02: login real e catalogo Xtream"
git push
```

Depois vá em:

```text
Actions > Build Android APK > Run workflow
```

## Observação de segurança

Nesta Sprint 02 as DNS ainda podem estar no arquivo `assets/config/servers.json`, conforme definido no projeto atual. A proteção/ocultação e atualização remota de servidores fica para a próxima etapa.
