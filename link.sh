#!/usr/bin/env bash
# Cria os symlinks dos dotfiles para o sistema.
# Idempotente: faz backup de arquivos reais e refaz links existentes.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d%H%M%S)"

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    mv "$dest" "$dest.bak.$STAMP"
    echo "  backup: $dest.bak.$STAMP"
  fi
  ln -s "$src" "$dest"
  echo "  link:   $dest -> $src"
}

echo "Shell e git..."
link "$DOTFILES/.zshrc"    "$HOME/.zshrc"
link "$DOTFILES/.p10k.zsh" "$HOME/.p10k.zsh"
link "$DOTFILES/.gitconfig" "$HOME/.gitconfig"

echo "Ghostty (terminal)..."
link "$DOTFILES/config/ghostty/config" "$HOME/.config/ghostty/config"

echo "Neovim (config kickstart.nvim)..."
link "$DOTFILES/config/nvim" "$HOME/.config/nvim"

echo "herdr (runtime dos agentes)..."
link "$DOTFILES/config/herdr/config.toml" "$HOME/.config/herdr/config.toml"

echo "omp (extensoes)..."
link "$DOTFILES/config/omp/extensions/model-role-status.ts" "$HOME/.omp/agent/extensions/model-role-status.ts"

echo "AeroSpace (window manager)..."
link "$DOTFILES/config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"

echo "Scripts auxiliares (~/.local/bin)..."
for script in "$DOTFILES"/bin/*; do
  link "$script" "$HOME/.local/bin/$(basename "$script")"
done

echo "Documentacao..."
link "$DOTFILES/docs/herdr-cheatsheet.md" "$HOME/.config/herdr-cheatsheet.md"

echo
echo "Pronto. Recarregue as configs:"
echo "  herdr server reload-config   # se o herdr estiver rodando"
echo "  Ghostty: Cmd+Shift+R"
