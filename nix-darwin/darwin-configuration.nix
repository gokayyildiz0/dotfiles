{ pkgs, config, ... }:

{
  # System packages
  environment.systemPackages = [
    pkgs.vim
    pkgs.direnv
    pkgs.sshs
  ];

  # Enable nix-daemon and experimental features
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  # Zsh and other basic programs
  programs.zsh.enable = true;
  system.stateVersion = 5; # Use an integer for state version
security.pam.enableSudoTouchIdAuth = true;
  # User-specific settings
  users.users.gokayyildiz.home = "/Users/gokayyildiz/";
  home-manager.backupFileExtension = "backup";
  nix.configureBuildUsers = true;
  nix.useDaemon = true;

  # Configure Homebrew
  homebrew.enable = true;
  homebrew.casks = [
    "font-meslo-lg-nerd-font"
    "wezterm"
  ];
  homebrew.brews = [
    "neovim"
  ];

  # macOS defaults
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "Hondlabs";
    screencapture.location = "~/Documents/Workspace/Assets/Screenshots";
    screensaver.askForPasswordDelay = 10;
  };
}
