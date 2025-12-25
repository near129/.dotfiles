{
  config,
  pkgs,
  username,
  ...
}:
let
  mkSymlink =
    path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/${path}";
in
{
  nixpkgs.config.allowUnfree = true;
  home = {
    username = username;
    stateVersion = "25.05";
    packages = with pkgs; [
      _1password-cli
      awscli2
      bottom
      claude-code
      codex
      delta
      direnv
      diskus
      dive
      dua
      eza
      fastfetch
      fd
      ffmpeg
      # fish # installed via nix-darwin
      fishPlugins.tide
      gh
      (google-cloud-sdk.withExtraComponents (
        with pkgs.google-cloud-sdk.components;
        [
          cloud-run-proxy
        ]
      ))
      jq
      k9s
      lazygit
      mycli
      neovim
      nh
      pandoc
      pre-commit
      procs
      pv
      ripgrep
      ripgrep-all
      rsync
      smartmontools
      starship
      terraform
      tmux
      vivid
      wget
      xh
      zellij

      # Programming languages and runtimes
      go
      nodejs
      pnpm
      rustup
      uv

      # Language servers and formatters, linters
      basedpyright
      bash-language-server
      biome
      docker-language-server
      gopls
      lua-language-server
      markdownlint-cli2
      nixd
      nixfmt-rfc-style
      pyrefly
      pyright
      ruff
      shfmt
      stylua
      tailwindcss-language-server
      taplo
      ty
      typescript-language-server
      vscode-langservers-extracted # json
      yaml-language-server
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
  imports = [
    ./programs/git.nix
    ./programs/fzf.nix
    ./programs/ruff.nix
    ./programs/zsh.nix
  ];
  xdg = {
    enable = true;
    configFile = {
      "nvim".source = mkSymlink "./.config/nvim";
      "zellij".source = mkSymlink "./.config/zellij";
      "wezterm".source = mkSymlink "./.config/wezterm";
      "tmux".source = mkSymlink "./.config/tmux";
      "karabiner/karabiner.json".source = mkSymlink "./.config/karabiner/karabiner.json";
      "alacritty".source = mkSymlink "./.config/alacritty";
      "starship.toml".source = mkSymlink "./.config/starship.toml";
      "aerospace".source = mkSymlink "./.config/aerospace";
      "codex/config.toml".source = mkSymlink "./.config/codex/config.toml";
      "fish".source = mkSymlink "./.config/fish";
      "ghostty".source = mkSymlink "./.config/ghostty";
    };
  };
  home = {
    file = {
      ".claude/settings.json".source = mkSymlink "./.config/claude/settings.json";
      ".claude/CLAUDE.md".source = mkSymlink "./.config/claude/CLAUDE.md";
      ".claude/agents".source = mkSymlink "./.config/claude/agents";
    };
  };
}
