{ config, pkgs, ... }:

{
  home.username = "gokayyildiz";
  home.homeDirectory = "/Users/gokayyildiz/";
  home.stateVersion = "23.05";

  # Home Manager configuration for dotfiles
  home.file = {
    #".zshrc".source = "${dotfiles}/zshrc/.zshrc";
    #".config/wezterm".source = "${dotfiles}/wezterm";
    #".config/starship".source = "${dotfiles}/starship";
    #".config/zellij".source = "${dotfiles}/zellij";
    #".config/nvim".source = "${dotfiles}/nvim";
    #".config/nix".source = "${dotfiles}/nix";
    #".config/nix-darwin".source = "${dotfiles}/nix-darwin";
    #".config/tmux".source = "${dotfiles}/tmux";
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
