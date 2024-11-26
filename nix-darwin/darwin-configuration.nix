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

  # User-specific settings
  users.users.gokayyildiz.home = "/Users/gokayyildiz/";

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
    loginwindow.LoginwindowText = "Gökay Yıldız";
    screencapture.location = "~/Documents/Workspace/Assets/Screenshots";
    screensaver.askForPasswordDelay = 10;
  };
}
