# herdr — atalhos (Lucro Rural)

`herdr` é o runtime dos agentes. Prefixo padrão: `ctrl+b`.
Os atalhos `Cmd+...` do Ghostty enviam `ctrl+b` + a tecla de ação.

## Abas

| Atalho | Ação |
| --- | --- |
| `Cmd+1..9` | ir para a aba N (número mostrado na sidebar) |
| `Cmd+Shift+[` / `Cmd+Shift+]` | aba anterior / próxima |
| `Cmd+0` / `Cmd+Shift+E` | goto (seletor) |
| `Cmd+Ctrl+0` | aba anterior |
| `Ctrl+Tab` | última aba usada (MRU, igual Dia); apertar de novo volta |
| `Cmd+Shift+O` | **nova aba com omp** (nomeia sozinha) |
| `Cmd+Shift+T` | nova aba de shell |
| `Cmd+Ctrl+W` | fechar aba |
| `ctrl+b shift+t` | renomear aba |

## Panes e navegação

| Atalho | Ação |
| --- | --- |
| `Cmd+D` (ou `Cmd+Ctrl+D`) | split vertical (pane novo com shell, mesma aba) |
| `Cmd+Shift+D` (ou `Cmd+Ctrl+Shift+D`) | split horizontal |
| `Cmd+Shift+Enter` | zoom no pane |
| `ctrl+b h/j/k/l` | mover entre panes |
| `Cmd+Ctrl+Tab` | alterna os dois últimos panes |
| `Cmd+Ctrl+,` / `Cmd+Ctrl+.` | agente anterior / próximo (pula entre workspaces) |
| `Cmd+Ctrl+[` / `Cmd+Ctrl+]` | workspace anterior / próximo |
| `Cmd+Shift+1..9` | ir para o workspace N |
| `Cmd+Shift+S` | seletor de workspaces |
| `ctrl+b b` | mostrar/ocultar sidebar |
| `ctrl+b q` | detach (tudo continua rodando) |
| `ctrl+b ?` | ajuda com todas as teclas |

## Comandos do shell

| Comando | Ação |
| --- | --- |
| `hw [nome]` | workspace para o diretório atual |
| `tw <nome>` | nova aba nomeada |
| `hs` | status do servidor |
| `hl` | listar workspaces |
| `hk` | parar o servidor (encerra tudo) |
| `NO_HERDR=1 zsh` | shell sem entrar no herdr |

## Agentes dentro do herdr (omp e Claude Code)

A sidebar mostra cada sessão de agente com estado:

- **working** — rodando
- **blocked** — esperando decisão sua
- **idle / done** — pronto para o próximo pedido

A aba é renomeada sozinha com o título da sessão
(ex.: "Capital do Peru"). Renomear à mão desativa o auto-nome.

Peças:

- `~/.local/bin/herdr-omp-tab` / `herdr-claude-tab` — abrem a aba com o agente
- `~/.local/bin/herdr-omp-autoname` / `herdr-claude-autoname` — daemons que renomeiam a aba
- `~/.config/herdr/config.toml` — teclas, tema, sidebar

Dica: o número da aba não é reindexado quando você fecha abas, então
`Cmd+1..4` pode não apontar para nada. Prefira `Cmd+Shift+[`/`]` para andar
em sequência e `Cmd+Ctrl+,`/`.` para pular direto entre agentes.

Diagnóstico: `herdr agent list`, `herdr agent explain <pane>`, `herdr integration status`.

> Não rode `tmux` dentro do herdr: a detecção de agentes passa a ver o tmux
> como processo do pane e o estado do agente some.
