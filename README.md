# My Dotfiles

## Run it

```bash
chmod +x setup.sh

# XCode
xcode-select --install

# Instalar Rosetta
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

echo "Instalando Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Instalar Homebrew packages
echo "Instalando pacotes do Brewfile..."
brew bundle --file ~/.dotfiles/Brewfile

echo "Executando setup.sh.."
./setup.sh
```
