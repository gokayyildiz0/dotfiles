{ config, pkgs, ... }:

let
  dotfiles = builtins.path {
    path = "/Users/gokayyildiz/dotfiles"; # Absolute path to your dotfiles
  };
in
{
  home.username = "gokayyildiz";
  home.homeDirectory = "/Users/gokayyildiz/";
  home.stateVersion = "23.05";

  # Home Manager configuration for dotfiles
  home.file = {
    ".zshrc".source = "${config.home.homeDirectory}/dotfiles/zshrc/.zshrc";
    ".config/wezterm".source = "${config.home.homeDirectory}/dotfiles/wezterm";
    ".config/starship".source = "${config.home.homeDirectory}/dotfiles/starship";
    ".config/zellij".source = "${config.home.homeDirectory}/dotfiles/zellij";
    ".config/nvim".source = "${config.home.homeDirectory}/dotfiles/nvim";
    ".config/nix".source = "${config.home.homeDirectory}/dotfiles/nix";
    ".config/nix-darwin".source = "${config.home.homeDirectory}/dotfiles/nix-darwin";
    ".config/tmux".source = "${config.home.homeDirectory}/dotfiles/tmux";
  };

  home.sessionVariables = { };

  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];

  programs.home-manager.enable = true;

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