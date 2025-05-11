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
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.11"; # Please read the comment before changing.
    packages = with pkgs; [
      bottom
      delta
      direnv
      diskus
      dua
      eza
      fastfetch
      fd
      ffmpeg
      gh
      jq
      k9s
      lazygit
      mycli
      # neovim
      nodejs # needed for nvm copilot
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
      volta
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
  xdg.configFile = {
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
  };
}
