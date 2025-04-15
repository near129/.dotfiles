{ config, pkgs, ... }:
let
  username = "near129";
  email = "56579877+near129@users.noreply.github.com";
  dotConfigDir = ../../.config;
in
{
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.11"; # Please read the comment before changing.
    packages = with pkgs; [
      bat
      bottom
      direnv
      diskus
      dua
      eza
      fastfetch
      fd
      # ffmpeg-full
      fzf
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
  };
  xdg.configFile."git/ignore".source = dotConfigDir + /git/ignore;
}
