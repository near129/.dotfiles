{
  config,
  pkgs,
  username,
  ...
}:
let
  mkSymlink = p: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/${p}";
in
{
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
      neovim
      nh
      opencode
      oxlint
      oxfmt
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
      tree-sitter
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
      "aerospace".source = mkSymlink "./.config/aerospace";
      "alacritty".source = mkSymlink "./.config/alacritty";
      "codex/config.toml".source = mkSymlink "./.config/codex/config.toml";
      "fish".source = mkSymlink "./.config/fish";
      "ghostty".source = mkSymlink "./.config/ghostty";
      "karabiner/karabiner.json".source = mkSymlink "./.config/karabiner/karabiner.json";
      "nvim".source = mkSymlink "./.config/nvim";
      "opencode".source = mkSymlink "./.config/opencode";
      "starship.toml".source = mkSymlink "./.config/starship.toml";
      "tmux".source = mkSymlink "./.config/tmux";
      "wezterm".source = mkSymlink "./.config/wezterm";
      "zellij".source = mkSymlink "./.config/zellij";
    };
  };
  home = {
    file = {
      ".claude/CLAUDE.md".source = mkSymlink "./.config/claude/CLAUDE.md";
      ".claude/agents".source = mkSymlink "./.config/claude/agents";
      ".claude/settings.json".source = mkSymlink "./.config/claude/settings.json";
    };
  };
}
