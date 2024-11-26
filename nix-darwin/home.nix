{ config, pkgs, ... }:

let
  dotfiles = builtins.path {
    path = ../dotfiles;  # This resolves the `dotfiles` directory relative to the flake
    name = "dotfiles";   # Optional: Provides a name for the imported path
  };
in
{
  home.username = "gokayyildiz";
  home.homeDirectory = "/Users/gokayyildiz/";
  home.stateVersion = "23.05";

  home.file = {
    ".zshrc".source = "${dotfiles}/zshrc/.zshrc";
    ".config/wezterm".source = "${dotfiles}/wezterm";
    ".config/starship".source = "${dotfiles}/starship";
    ".config/zellij".source = "${dotfiles}/zellij";
    ".config/nvim".source = "${dotfiles}/nvim";
    ".config/nix".source = "${dotfiles}/nix";
    ".config/nix-darwin".source = "${dotfiles}/nix-darwin";
    ".config/tmux".source = "${dotfiles}/tmux";
  };



  # Specify session variables
  home.sessionVariables = { };

  # Extend session PATH
  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Enable Zsh configuration
  programs.zsh = {
    enable = true;
    initExtra = ''
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
