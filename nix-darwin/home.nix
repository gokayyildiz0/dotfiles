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
    ".zshrc".source = "${dotfiles}/zshrc/.zshrc";
    ".config/wezterm".source = "${dotfiles}/wezterm";
    ".config/starship".source = "${dotfiles}/starship";
    ".config/zellij".source = "${dotfiles}/zellij";
    ".config/nvim".source = "${dotfiles}/nvim";
    ".config/nix".source = "${dotfiles}/nix";
    ".config/nix-darwin".source = "${dotfiles}/nix-darwin";
    ".config/tmux".source = "${dotfiles}/tmux";
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