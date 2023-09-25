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
git clone --recurse-submodules https://github.com/felipe-jm/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

echo "Instalando NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

echo "Instalando versão LTS do Node"
nvm install --lts

# Criando containers do postgres, mongo e redis
echo "Puxando imagem do Docker para PostgreSQL..."
docker run --name postgres -e POSTGRES_PASSWORD=docker -p 5432:5432 -d postgres

echo "Puxando imagem do Docker para Mongo..."
docker run --name mongo -p 27017:27017 -d -t mongo

echo "Puxando imagem do Docker para Redis..."
docker run --name redis -p 6379:6379 -d -t redis:alpine

# Instalar Yarn
echo "Instalando Yarn..."
npm install --global yarn

# Instalar Python 3.11 via pyenv
echo "Instalando Python 3.11 via pyenv..."
pyenv install 3.11.0
pyenv global 3.11.0

### Instalar Oh My ZSH
echo "Instalando Oh My Zsh..."
sudo sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm -rf ~/.zshrc

# Instalando tema spaceship
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"

ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

### Finalização
cd ~ && mkdir ./Developer

echo "Todas as ferramentas foram instaladas!"