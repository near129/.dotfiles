{ config, pkgs, ... }:
let
  username = "near129";
  email = "56579877+near129@users.noreply.github.com";
  dotConfigDir = ../../.config;
  macosGitignoreMacosPath = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Global/macOS.gitignore";
    sha256 = "0r7gjyqjg0hy9vcynpllly6viqgcfhfy7d8haqfdj1zqkjcdpmx7";
  };
  macosGitignoreMacos = builtins.readFile macosGitignoreMacosPath;
in
{
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.11"; # Please read the comment before changing.
    packages = with pkgs; [
      bottom
      direnv
      diskus
      dua
      eza
      fastfetch
      fd
      # ffmpeg-full
      gh
      delta
      jq
      k9s
      mycli
      neovim
      pandoc
      procs
      pv
      ripgrep
      ripgrep-all
      rsync
      # rust
      # cargo
      smartmontools
      starship
      stylua
      uv
      vivid
      wget
      xh
      zoxide
      nil
      nixd
      nixfmt-rfc-style
      tmux
      zellij
    ];
  };
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initExtraBeforeCompInit = builtins.readFile (dotConfigDir + /zsh/.zshrc);
    profileExtra = builtins.readFile (dotConfigDir + /zsh/.zprofile);
    envExtra = builtins.readFile (dotConfigDir + /zsh/.zshenv);
  };
  programs.git = {
    enable = true;
    userName = username;
    userEmail = email;
    signing = {
      signByDefault = true;
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC+0IqYbnBD7Cjh+DvaSucRW02cbc5i4peT86vfYMDH1";
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
    ignores = [
      macosGitignoreMacos
    ];
    aliases = {
      pushf = "push --force-with-lease";
      tree = "log --graph --pretty=format:'%C(auto)%h %d %s %C(blue)(%cr) %C(green)<%an>'";
    };
    extraConfig = {
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
    };
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers";
        syntaxTheme = "Nord";
      };
    };
  };
  programs.bat = {
    enable = true;
    config.theme = "Nord";
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "(fd --hidden --exclude .git -d 5 && fd --hidden --exclude .git --min-depth 6)";
    fileWidgetCommand = "(fd --hidden --exclude .git -d 5 && fd --hidden --exclude .git --min-depth 6)";
    fileWidgetOptions = [
      "--select-1"
      "--exit-0"
      "--preview '(bat  --color=always --style=header,grid --line-range :100 {} || exa -T -L 2) 2>/dev/null'"
    ];
    colors = {
      "fg" = "#d8dee9";
      "bg" = "#2e3440";
      "hl" = "#a3be8c";
      "fg+" = "#d8dee9";
      "bg+" = "#434c5e";
      "hl+" = "#a3be8c";
      "pointer" = "#bf616a";
      "info" = "#4c566a";
      "spinner" = "#4c566a";
      "header" = "#4c566a";
      "prompt" = "#81a1c1";
      "marker" = "#ebcb8b";
    };
  };
  xdg.configFile = {
    "nvim" = {
      source = dotConfigDir + /nvim;
      recursive = true;
    };
    "zellij" = {
      source = dotConfigDir + /zellij;
      recursive = true;
    };
    "wezterm" = {
      source = dotConfigDir + /wezterm;
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
