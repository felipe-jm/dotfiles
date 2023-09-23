#!/bin/bash

# XCode
xcode-select --install

# Atualizar o Homebrew (ou instalar se não estiver instalado)
if ! command -v brew &> /dev/null; then
    echo "Homebrew não encontrado. Instalando..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Atualizando Homebrew..."
    brew update
fi

# Instalar Zsh (já deve estar instalado no macOS, mas por precaução)
echo "Instalando Zsh..."
brew install zsh

# Definir Zsh como shell padrão (opcional)
chsh -s $(which zsh)

# Instalar Oh My Zsh
echo "Instalando Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Oh My ZSH
sudo sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm -rf ~/.zshrc

### Setup dotfiles
git clone --recurse-submodules https://github.com/felipe-jm/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

### Install Homebrew packages
brew bundle --file ~/.dotfiles/Brewfile

# Instalar NVM
echo "Instalando NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install --lts

# Instalar Docker
echo "Instalando Docker..."
brew install --cask docker

# Criando imagens do postgres, mongo e redis
sudo docker run --name postgres -e POSTGRES_PASSWORD=docker -p 5432:5432 -d postgres
sudo docker run --name mongo -p 27017:27017 -d -t mongo
sudo docker run --name redis -p 6379:6379 -d -t redis:alpine

# Instalar Yarn
echo "Instalando Yarn..."
npm install --global yarn

# Instalar Python 3.11 via pyenv
echo "Instalando Python 3.11 via pyenv..."
pyenv install 3.11.0
pyenv global 3.11.0

# Install spaceship ZSH theme
git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME/.zsh/spaceship"

### Finalização
cd ~ && mkdir ./Developer

echo "Todas as ferramentas foram instaladas!"