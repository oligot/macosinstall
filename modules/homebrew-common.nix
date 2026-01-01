{ pkgs, ... }:
{
  homebrew = {
    enable = true;

    taps = [
      "tw93/tap"
    ];

    brews = [
      "mole"
    ];

    casks = [
      "firefox"
      "ghostty"
      "raycast"
    ];

    onActivation.cleanup = "zap";
  };
}
