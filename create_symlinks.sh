
#!/bin/bash

# Define the base directory of your dotfiles
DOTFILES_DIR=~/dotfiles

# Symlink .zshrc
ln -sf "$DOTFILES_DIR/zshrc/.zshrc" ~/.zshrc

# Symlink starship config
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/starship/starship.toml" ~/.config/starship.toml

# Symlink wezterm config
ln -sf "$DOTFILES_DIR/wezterm/.wezterm.lua" ~/.wezterm.lua

# Symlink tmux config
ln -sf "$DOTFILES_DIR/tmux" ~/.config/tmux

# Symlink nvim config
ln -sf "$DOTFILES_DIR/nvim" ~/.config/nvim


echo "Symlinks created successfully!"
