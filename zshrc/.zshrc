# -----------------
# PATH Configuration
# -----------------
export PATH=$HOME/bin:/usr/local/bin:$PATH

# -----------------
# Aliases
# -----------------
# Enhanced `eza` Aliases (ls replacement)
alias l="eza --icons"
alias ls="eza --icons"
alias ll="eza -lg --icons"
alias la="eza -lag --icons"
alias lt="eza -lTg --icons"
alias lt1="eza -lTg --level=1 --icons"
alias lt2="eza -lTg --level=2 --icons"
alias lt3="eza -lTg --level=3 --icons"
alias lta="eza -lTag --icons"
alias lta1="eza -lTag --level=1 --icons"
alias lta2="eza -lTag --level=2 --icons"
alias lta3="eza -lTag --level=3 --icons"

# Quick Navigation with Zoxide
alias ..='z ..'
alias ...='z ../..'
alias ....='z ../../..'
alias .....='z ../../../..'
alias ......='z ../../../../..'
alias cd="z" # Leverage zoxide for directory navigation

# File Search and Open
alias fz="fzf --preview='bat {}'" # Fuzzy finder with preview

# Function to open files via fzf and nvim
fzn() {
  local file
  file=$(fzf --preview='bat --color=always {}') || return
  [ -n "$file" ] && nvim "$file"
}

# Git and LazyGit
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'
alias lg="lazygit"

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Zoxide + FZF Integration 
alias zf="zoxide query -l | fzf --preview 'tree {}'" # Fuzzy finder for directory navigation 

# Network Scanning
alias nm="nmap -sC -sV -oN nmap" # Nmap with common scan flags

# Safe Deletion
alias rm="rm -i" # Confirm before deleting files

# Reload Zsh Configuration
alias reload="source ~/.zshrc" # Quick reload of Zsh config

#Clear
alias cl="clear"

#Vim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

#Npm
alias npm="pnpm"
alias dev="pnpm run dev"

# -----------------
# Prompt Configuration (Starship)
# -----------------
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# -----------------
# Syntax Highlighting
# -----------------
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# -----------------
# Auto-suggestions
# -----------------
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# -----------------
# FZF (Search Plugin)
# -----------------
if type fzf &>/dev/null; then
  source <(fzf --zsh)

  export FZF_CTRL_R_OPTS="
  --color header:italic
  --height=80%
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'CTRL-Y: Copy command into clipboard, CTRL-/: Toggle line wrapping, CTRL-R: Toggle sorting by relevance'
  "

  export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --height=80%
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --header 'CTRL-/: Toggle preview window position'
  "

  export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'
  --height=80%
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --header 'CTRL-/: Toggle preview window position'
  "
fi
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
if [ -n "$TMUX" ]; then
  export SSH_AUTH_SOCK=$(tmux show-environment | grep -oP '^SSH_AUTH_SOCK=\K.*')
fi

# Nix!
export NIX_CONF_DIR=$HOME/.config/nix
export PATH=/run/current-system/sw/bin:$PATH

# -----------------
# History Settings
# -----------------
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt share_history      # Share history across sessions
setopt append_history     # Append new commands to history
setopt inc_append_history # Append commands as they are entered

# -----------------
# Zsh Options
# -----------------
setopt auto_cd            # Automatically change to directories without 'cd'
setopt no_beep            # Disable terminal beep
setopt correct            # Correct directory names
setopt complete_in_word   # Autocompletion in the middle of a word

# -----------------
# The Fuck (Command Correction)
# -----------------
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# -----------------
# Zoxide (Smart Directory Navigation)
# -----------------
eval "$(zoxide init zsh)"

# -----------------
# Export Editor
# -----------------
export EDITOR=nvimxport EDITOR=nvim
