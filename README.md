# My Dotfiles

## Run it

```bash
chmod +x setup.sh

# XCode
xcode-select --install

echo "Homebrew não encontrado. Instalando..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

### Install Homebrew packages
brew bundle --file ~/.dotfiles/Brewfile

./setup.sh
```
