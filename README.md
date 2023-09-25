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
```
