# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt appendhistory

# Completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Completion: checagem completa (compaudit + dump) no máximo 1x por dia; nos
# outros shells usa o dump em cache. Precisa vir antes do nvm e do gcloud,
# que chamariam compinit sem cache.
autoload -Uz compinit
_zcd=(~/.zcompdump(N.mh-24))
if (( $#_zcd )); then compinit -C; else compinit; fi
unset _zcd

# nvm sob demanda: node default direto no PATH, sem `nvm use` (custava ~3 s).
# Ao trocar a versão default (`nvm alias default X`), atualizar o caminho abaixo.
export NVM_DIR="$HOME/.nvm"
export PATH="$NVM_DIR/versions/node/v20.20.1/bin:$PATH"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.local/bin:$PATH"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Created by `pipx` on 2024-01-15 15:29:51
export PATH="$PATH:/Users/felipejung/.local/bin"

export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"

export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"

# Java configuration
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$JAVA_HOME/bin:$PATH"
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
#
# rbenv: só os shims no PATH (o `rbenv init` custava ~0,4 s)
export PATH="$HOME/.rbenv/shims:$PATH"

# Added by Windsurf
export PATH="/Users/felipejung/.codeium/windsurf/bin:$PATH"

export HISTTIMEFORMAT="[%F %T] "

# Added by Antigravity
export PATH="/Users/felipejung/.antigravity/antigravity/bin:$PATH"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- Eza (better ls) -----
alias ls="eza --icons=always"

# Alias for bat (cat with syntax highlighting)
#alias cat="bat"

# Alias to vim open nvim
alias vim='nvim'

# GCP project + zone default
export CLOUDSDK_CORE_PROJECT=river-octagon-445615-p2
export CLOUDSDK_COMPUTE_ZONE=us-east1-c

# SSH por VM — todas via IAP
alias gssh-cafe='gcloud compute ssh app-cafe --zone=us-east1-c --tunnel-through-iap'
alias gssh-celery='gcloud compute ssh queue-celery --zone=us-east1-c --tunnel-through-iap'
alias gssh-acucar='gcloud compute ssh db-acucar --zone=us-east1-c --tunnel-through-iap'
alias gssh-algodao-app='gcloud compute ssh algodao-app --zone=us-east1-c --tunnel-through-iap'
alias gssh-algodao-db='gcloud compute ssh algodao-db --zone=us-east1-c --tunnel-through-iap'
alias gssh-nfr-app='gcloud compute ssh nfr-app --zone=us-east1-c --tunnel-through-iap'
alias gssh-nfr-db='gcloud compute ssh nfr-db --zone=us-east1-c --tunnel-through-iap'
alias gssh-fiscal-pdfs='gcloud compute ssh lucrorural-fiscal-pdfs --zone=us-east1-c --tunnel-through-iap'
alias gssh-vendas='gcloud compute ssh lucrorural-vendas --zone=us-central1-c --tunnel-through-iap'
alias gssh-cs='gcloud compute ssh lucrorural-cs --tunnel-through-iap --zone=us-central1-c'
alias gssh-terminal='gcloud compute ssh terminal-app --tunnel-through-iap --zone=us-east1-c'

# SCP equivalente
alias gscp-cafe='gcloud compute scp --zone=us-east1-c --tunnel-through-iap'
alias gscp-celery='gcloud compute scp --zone=us-east1-c --tunnel-through-iap'
alias gscp-acucar='gcloud compute scp --zone=us-east1-c --tunnel-through-iap'
alias gscp-algodao-app='gcloud compute scp --zone=us-east1-c --tunnel-through-iap'
alias gscp-algodao-db='gcloud compute scp --zone=us-east1-c --tunnel-through-iap'
alias gscp-vendas='gcloud compute scp --zone=us-central1-c --tunnel-through-iap'
alias gscp-cs='gcloud compute scp --zone=us-central1-c --tunnel-through-iap'
alias gscp-terminal='gcloud compute scp --zone=us-east1-c --tunnel-through-iap'

# Prod
alias tunnel-db-acucar='gcloud compute ssh app-cafe --zone=us-east1-c --tunnel-through-iap -- -L 5433:10.142.0.3:5432 -N'
alias tunnel-db-nfr='gcloud compute ssh nfr-app --zone=us-east1-c --tunnel-through-iap -- -L 5434:10.142.0.8:5432 -N'

# Staging
alias tunnel-db-algodao='gcloud compute ssh algodao-app --zone=us-east1-c --tunnel-through-iap -- -L 5435:10.142.0.10:5432 -N'

export PATH="$HOME/bin:$PATH"

# opencode
export PATH=/Users/felipejung/.opencode/bin:$PATH

# Pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"

#eval "$(pyenv init - zsh)"

# NOTION_TOKEN vive em ~/.zsh_secrets (nao versionado)

alias claude-mem='/Users/felipejung/.bun/bin/bun "/Users/felipejung/.claude/plugins/cache/thedotmack/claude-mem/10.6.1/scripts/worker-service.cjs"'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/felipejung/Developer/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/felipejung/Developer/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/felipejung/Developer/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/felipejung/Developer/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(zoxide init zsh)"

export _ZO_DOCTOR=0

# TERMINAL_API_KEY vive em ~/.zsh_secrets (nao versionado)

# ---------- herdr workflow (agentes) ----------
# herdr e' o runtime dos agentes; substitui o tmux.
alias hs='herdr status'
alias hl='herdr workspace list'
alias hk='herdr server stop'
alias cheat='glow ~/.config/herdr-cheatsheet.md 2>/dev/null || bat ~/.config/herdr-cheatsheet.md 2>/dev/null || cat ~/.config/herdr-cheatsheet.md'

# hw [nome]: workspace para o diretorio atual
hw() {
  local name="${1:-$(basename "$PWD")}"
  herdr workspace create --cwd "$PWD" --label "$name" --focus >/dev/null
}

# tw <nome>: cria uma aba nomeada no workspace atual
tw() {
  local name="${1:?uso: tw <nome>}"
  herdr tab create --cwd "$PWD" --label "$name" --focus >/dev/null
}

export PATH="$HOME/.local/bin:$PATH"

# Secrets locais (tokens, chaves). Nao versionado.
[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

# Perfis de conta do Claude Code: conta | conta <perfil> | conta nova <nome> [email] | conta lista
[ -f ~/.claude/scripts/claude-perfis.zsh ] && source ~/.claude/scripts/claude-perfis.zsh
