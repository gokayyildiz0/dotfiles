{ config, pkgs, ... }:

{
  home.username = "gokayyildiz";
  home.homeDirectory = "/Users/gokayyildiz/";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # User-specific packages
  home.packages = [];

  # Manage dotfiles through Home Manager
  home.file = {
    ".zshrc".source = ./dotfiles/zshrc/.zshrc;                 # Relative path to the .zshrc file
    ".config/wezterm".source = ./dotfiles/wezterm;             # Relative path to the wezterm config
    ".config/starship".source = ./dotfiles/starship;           # Relative path to the starship config
    ".config/zellij".source = ./dotfiles/zellij;               # Relative path to the zellij config
    ".config/nvim".source = ./dotfiles/nvim;                   # Relative path to the Neovim config
    ".config/nix".source = ./dotfiles/nix;                     # Relative path to the Nix config
    ".config/nix-darwin".source = ./dotfiles/nix-darwin;       # Relative path to nix-darwin config
    ".config/tmux".source = ./dotfiles/tmux;                   # Relative path to tmux config
  };

  # Add custom session variables
  home.sessionVariables = { };

  # Extend session PATH
  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];

  # Enable Home Manager as a program
  programs.home-manager.enable = true;

  # Zsh configuration
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Add any additional configurations here
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
