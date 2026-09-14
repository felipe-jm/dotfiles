#!/bin/bash

if ! command -v brew &> /dev/null; then
    echo "Homebrew não encontrado! Cancelando execução.."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Instalando Zsh..."
brew install zsh

# Definir Zsh como shell padrão (opcional)
chsh -s $(which zsh)

### Setup dotfiles
if [ ! -d ~/.dotfiles ]; then
  git clone --recurse-submodules https://github.com/felipe-jm/dotfiles.git ~/.dotfiles
fi
cd ~/.dotfiles

echo "Instalando NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

echo "Instalando versão LTS do Node"
nvm install --lts

# Instalar Yarn
echo "Instalando Yarn..."
npm install --global yarn

# Instalar Python 3.11 via pyenv
echo "Instalando Python 3.11 via pyenv..."
pyenv install 3.11.0
pyenv global 3.11.0

### Prompt e plugins do zsh
# O .zshrc usa Powerlevel10k + zsh-autosuggestions + zsh-syntax-highlighting
# instalados via Homebrew (ja vem no Brewfile). Oh My Zsh nao e mais usado.
echo "Prompt: rode 'p10k configure' depois, se quiser reconfigurar."

### herdr - runtime dos agentes de codigo (nao esta no Homebrew)
if ! command -v herdr &> /dev/null; then
    echo "Instalando herdr..."
    curl -fsSL https://herdr.dev/install.sh | sh
fi

### Symlinks de configuracao (zsh, git, ghostty, herdr, aerospace, scripts)
echo "Criando symlinks de configuracao..."
~/.dotfiles/link.sh

### Finalização
cd ~ && mkdir -p ./Developer

echo "Todas as ferramentas foram instaladas!"