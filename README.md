# My Dotfiles

## Run it

```bash
# XCode
xcode-select --install

echo "Instalando Rosetta..."
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

echo "Instalando Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Instalando pacotes do Brewfile..."
brew bundle --file ~/.dotfiles/Brewfile

chmod +x setup.sh

echo "Executando setup.sh.."
./setup.sh

# Criar containers do postgres, mongo e redis
echo "Puxando imagem do Docker para PostgreSQL..."
docker run --name postgres -e POSTGRES_PASSWORD=docker -p 5432:5432 -d postgres

echo "Puxando imagem do Docker para Mongo..."
docker run --name mongo -p 27017:27017 -d -t mongo

echo "Puxando imagem do Docker para Redis..."
docker run --name redis -p 6379:6379 -d -t redis:alpine
```

## O que tem aqui

```
.zshrc .gitconfig          shell e git
Brewfile                   pacotes do Homebrew
link.sh                    cria todos os symlinks (idempotente)
setup.sh                   instalacao completa numa maquina nova
config/ghostty/config      terminal Ghostty
config/herdr/config.toml   herdr (runtime dos agentes)
config/aerospace/          AeroSpace (window manager)
bin/                       scripts auxiliares -> ~/.local/bin
docs/herdr-cheatsheet.md   atalhos do herdr
```

Para aplicar as configs numa maquina que ja esta montada:

```bash
cd ~/.dotfiles && ./link.sh
herdr server reload-config   # se o herdr estiver rodando
# Ghostty: Cmd+Shift+R
```

## Terminal + agentes

O terminal e o [Ghostty](https://ghostty.org) e os agentes de codigo rodam
dentro do [herdr](https://herdr.dev), que substitui o tmux. O herdr nao esta
no Homebrew, entao o `setup.sh` o instala via `curl -fsSL https://herdr.dev/install.sh | sh`.

O Ghostty traduz atalhos `Cmd+...` no prefixo do herdr (`ctrl+b`) mais a tecla
de acao, para a navegacao ficar com atalhos de macOS em vez de acordes de
prefixo. Os principais:

| Atalho | Acao |
| --- | --- |
| `Cmd+1..9` | ir para a aba N |
| `Cmd+Shift+[` / `]` | aba anterior / proxima |
| `Cmd+Ctrl+,` / `.` | agente anterior / proximo |
| `Cmd+Ctrl+[` / `]` | workspace anterior / proximo |
| `Cmd+Shift+1..9` | ir para o workspace N |
| `Cmd+0` | goto (seletor) |
| `Cmd+Shift+N` | nova aba com Jcode |

A lista completa esta em [`docs/herdr-cheatsheet.md`](docs/herdr-cheatsheet.md).
