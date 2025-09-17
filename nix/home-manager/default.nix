{
  config,
  pkgs,
  username,
  ...
}:
let
  dotConfigDir = ../../.config;
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  nixpkgs.config.allowUnfree = true;
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.05"; # Please read the comment before changing.
    packages = with pkgs; [
      _1password-cli
      awscli2
      bottom
      claude-code
      codex
      delta
      direnv
      diskus
      dua
      dive
      eza
      fastfetch
      fd
      ffmpeg
      # gemini-cli
      gh
      jq
      k9s
      lazygit
      mycli
      # neovim
      nh
      pandoc
      pre-commit
      procs
      pv
      ripgrep
      ripgrep-all
      rsync
      smartmontools
      # starship
      tmux
      vivid
      wget
      xh
      zellij
      # zoxide

      # nix
      nixd
      nixfmt-rfc-style
      # rust
      rustup
      # lua
      lua-language-server
      stylua
      # python
      uv
      ruff
      pyright
      # golang
      go
      gopls
      # javascript/typescript
      nodejs # needed for nvm copilot
      pnpm
      biome
      vscode-langservers-extracted
      # google cloud
      google-cloud-sdk
    ];
  };
  programs.home-manager.enable = true;
  programs.bat = {
    enable = true;
    config.theme = "Nord";
  };
  programs.yazi = {
    enable = true;
    settings.manager.show_hidden = true;
    enableZshIntegration = false;
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  imports = [
    ./programs/git.nix
    ./programs/fzf.nix
    ./programs/ruff.nix
    ./programs/zsh.nix
  ];
  xdg = {
    enable = true;
    configFile = {
      "nvim" = {
        # source = dotConfigDir + /nvim;
        source = mkOutOfStoreSymlink config.home.homeDirectory + /.dotfiles/.config/nvim;
        recursive = true;
      };
      "zellij" = {
        source = dotConfigDir + /zellij;
        recursive = true;
      };
      "wezterm" = {
        # source = dotConfigDir + /wezterm;
        source = mkOutOfStoreSymlink config.home.homeDirectory + /.dotfiles/.config/wezterm;
        recursive = true;
      };
      "tmux" = {
        source = dotConfigDir + /tmux;
        recursive = true;
      };
      "karabiner" = {
        source = dotConfigDir + /karabiner;
        recursive = true;
      };
      "alacritty" = {
        source = dotConfigDir + /alacritty;
        recursive = true;
      };
      "starship.toml".source = dotConfigDir + /starship.toml;
      "aerospace" = {
        # source = dotConfigDir + /aerospace;
        source = mkOutOfStoreSymlink config.home.homeDirectory + /.dotfiles/.config/aerospace;
        recursive = true;
      };
      "claude" = {
        # source = dotConfigDir + /claude;
        source = mkOutOfStoreSymlink config.home.homeDirectory + /.dotfiles/.config/claude;
        recursive = true;
      };
      "codex" = {
        source = dotConfigDir + /codex;
        recursive = true;
      };
    };
  };
}
