{ config, pkgs, ... }:

{
  home.username = "gokayyildiz";
  home.homeDirectory = "/Users/gokayyildiz/";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # User-specific packages
  home.packages = [];

  # Manage dotfiles through Home Manager
      home.file = {
            ".zshrc".source = "${self}/dotfiles/zshrc/.zshrc";
            ".config/wezterm".source = "${self}/dotfiles/wezterm";
            ".config/starship".source = "${self}/dotfiles/starship";
            ".config/zellij".source = "${self}/dotfiles/zellij";
            ".config/nvim".source = "${self}/dotfiles/nvim";
            ".config/nix".source = "${self}/dotfiles/nix";
            ".config/nix-darwin".source = "${self}/dotfiles/nix-darwin";
            ".config/tmux".source = "${self}/dotfiles/tmux";
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
