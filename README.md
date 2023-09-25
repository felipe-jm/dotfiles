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
