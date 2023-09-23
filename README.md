# My Dotfiles

## Running it

```bash
# XCode
chmod +x setup.sh

xcode-select --install

echo "Homebrew não encontrado. Instalando..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### Install Homebrew packages
brew bundle --file ~/.dotfiles/Brewfile

./setup.sh
```
