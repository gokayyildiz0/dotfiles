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

  home.file = {
    ".zshrc".source = "${HOME}/dotfiles/zshrc/.zshrc";
    ".config/wezterm".source = "${HOME}/dotfiles/wezterm";
    ".config/starship".source = "${HOME}/dotfiles/starship";
    ".config/zellij".source = "${HOME}/dotfiles/zellij";
    ".config/nvim".source = "${HOME}/dotfiles/nvim";
    ".config/nix".source = "${HOME}/dotfiles/nix";
    ".config/nix-darwin".source = "${HOME}/dotfiles/nix-darwin";
    ".config/tmux".source = "${HOME}/dotfiles/tmux";
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