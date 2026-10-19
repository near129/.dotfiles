{ pkgs, ... }: {
  imports = [
    ../default/darwin.nix
    ../../modules/darwin/homebrew.nix
  ];
  homebrew.brews = [
    "playwright-cli"
    "k1LoW/tap/mo"
  ];
  homebrew.casks = [
    "1password"
    "alacritty"
    "arc"
    "claude"
    "claude-code@latest"
    "codex"
    "codex-app"
    "copilot-cli"
    "docker-desktop"
    "firefox"
    "ghostty"
    "gimp"
    "github-copilot-app"
    "google-japanese-ime"
    "inkscape"
    "karabiner-elements"
    "lm-studio"
    "middleclick"
    "nikitabobko/tap/aerospace"
    "obsidian"
    "ollama-app"
    "thaw"
    "visual-studio-code"
    "wezterm@nightly"
    "windows-app"
    "zed"
    "zen"
    "google-chrome"
    "slack"
  ];
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    hackgen-font
    hackgen-nf-font
    source-han-code-jp
  ];
}
