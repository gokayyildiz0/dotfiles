#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR=""
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_DIR

BACKUP_DIR=""
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
readonly BACKUP_DIR

CONFIG_DIR=""
CONFIG_DIR="$HOME/.config"
readonly CONFIG_DIR

declare -i success_count=0
declare -i skip_count=0
declare -i error_count=0

print_color() {
  local color="$1"
  local message="$2"
  local code reset='\033[0m'

  case "$color" in
  green) code='\033[0;32m' ;;
  yellow) code='\033[1;33m' ;;
  red) code='\033[0;31m' ;;
  blue) code='\033[0;34m' ;;
  *) code='' ;;
  esac
  echo -e "${code}${message}${reset}"
}

log_info() {
  print_color blue "[INFO] $1"
}

log_success() {
  print_color green "[SUCCESS] $1"
}

log_warning() {
  print_color yellow "[WARNING] $1"
}

log_error() {
  print_color red "[ERROR] $1" >&2
}

backup_if_exists() {
  local target
  local backup_path

  target="$1"

  if [[ -e "$target" && ! -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    backup_path="$BACKUP_DIR/$(basename "$target")"
    mv "$target" "$backup_path"
    log_warning "Backed up $target to $backup_path"
    return 0
  elif [[ -L "$target" ]]; then
    rm "$target"
    return 0
  fi
  return 1
}

create_symlink() {
  local source
  local target
  local name
  local target_dir

  source="$1"
  target="$2"
  name="${3:-$(basename "$source")}"

  if [[ ! -e "$source" ]]; then
    log_error "$name: Source not found at $source"
    ((error_count++))
    return 1
  fi

  if [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$source" ]]; then
    log_info "$name: Already linked correctly, skipping"
    ((skip_count++))
    return 0
  fi

  backup_if_exists "$target"

  target_dir="$(dirname "$target")"
  mkdir -p "$target_dir"

  if ln -sf "$source" "$target"; then
    log_success "$name: $target → $source"
    ((success_count++))
  else
    log_error "$name: Failed to create symlink"
    ((error_count++))
    return 1
  fi
}

print_separator() {
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

main() {
  print_separator
  log_info "Starting dotfiles setup from: $DOTFILES_DIR"
  print_separator

  create_symlink "$DOTFILES_DIR/zshrc/.zshrc" "$HOME/.zshrc" "Zsh"
  create_symlink "$DOTFILES_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml" "Starship"
  create_symlink "$DOTFILES_DIR/tmux" "$CONFIG_DIR/tmux" "Tmux"
  create_symlink "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim" "Neovim"
  create_symlink "$DOTFILES_DIR/ghostty" "$CONFIG_DIR/ghostty" "Ghostty"
  create_symlink "$DOTFILES_DIR/nushell" "$HOME/Library/Application Support/nushell" "Nushell"
  create_symlink "$DOTFILES_DIR/yazi" "$CONFIG_DIR/yazi" "Yazi"

  if [[ -d "$DOTFILES_DIR/zellij" ]]; then
    create_symlink "$DOTFILES_DIR/zellij" "$CONFIG_DIR/zellij" "Zellij"
  fi

  if [[ -f "$DOTFILES_DIR/wezterm/.wezterm.lua" ]]; then
    create_symlink "$DOTFILES_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua" "WezTerm"
  fi

  print_separator
  log_success "✓ Setup complete!"
  print_color green "  Created: $success_count"
  [[ $skip_count -gt 0 ]] && print_color yellow "  Skipped: $skip_count"
  [[ $error_count -gt 0 ]] && print_color red "  Errors: $error_count"
  [[ -d "$BACKUP_DIR" ]] && log_info "Backups: $BACKUP_DIR"
  print_separator

  return $error_count
}

main "$@"
