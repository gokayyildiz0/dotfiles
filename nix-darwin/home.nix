{ config, pkgs, ... }:

{
  home.username = "gokayyildiz";
  home.homeDirectory = "/Users/gokayyildiz/";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # User-specific packages
  home.packages = [];

  # Manage dotfiles through Home Manager
   
  home.file = {
    ".zshrc".source = "${flakePath}/dotfiles/zshrc/.zshrc";
    ".config/wezterm".source = "${flakePath}/dotfiles/wezterm";
    ".config/starship".source = "${flakePath}/dotfiles/starship";
    ".config/zellij".source = "${flakePath}/dotfiles/zellij";
    ".config/nvim".source = "${flakePath}/dotfiles/nvim";
    ".config/nix".source = "${flakePath}/dotfiles/nix";
    ".config/nix-darwin".source = "${flakePath}/dotfiles/nix-darwin";
    ".config/tmux".source = "${flakePath}/dotfiles/tmux";
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
