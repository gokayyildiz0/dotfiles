{ config, pkgs, ... }:

{
  home.username = "gokayyildiz";
  home.homeDirectory = "/Users/gokayyildiz/";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # User-specific packages
  home.packages = [];

  # Manage dotfiles through Home Manager
   
    home.file = {
    ".zshrc".source = "/Users/gokayyildiz/dotfiles/zshrc/.zshrc";
    ".config/wezterm".source = "/Users/gokayyildiz/dotfiles/wezterm";
    ".config/starship".source = "/Users/gokayyildiz/dotfiles/starship";
    ".config/zellij".source = "/Users/gokayyildiz/dotfiles/zellij";
    ".config/nvim".source = "/Users/gokayyildiz/dotfiles/nvim";
    ".config/nix".source = "/Users/gokayyildiz/dotfiles/nix";
    ".config/nix-darwin".source = "/Users/gokayyildiz/dotfiles/nix-darwin";
    ".config/tmux".source = "/Users/gokayyildiz/dotfiles/tmux";
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
