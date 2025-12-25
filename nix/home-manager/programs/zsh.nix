{ config, lib, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    completionInit = "autoload -U compinit && compinit -C -d $HOME/.cache/zsh/zcompdump";
    autosuggestion.enable = true;
    history = {
      ignoreAllDups = true;
      path = "${config.xdg.stateHome}/zsh/history";
    };
    syntaxHighlighting.enable = true;
    autocd = true;
    defaultKeymap = "emacs";
    shellAliases = {
      mkdir = "mkdir -p";
      cp = "cp -i";
      ln = "ln -i";
      mv = "mv -i";
      rm = "rm -i";

      ls = "eza --icons=auto";
      cat = "bat";
      l = "ls";
      ll = "ls -lh";
      la = "ls -A";
      lt = "ls -T";
      lla = "ls -lA";
      lal = "ls -lA";
      df = "df -kh";
      du = "du -kh";
    };
    envExtra = ''
      ### locale ###
      export LANG="en_US.UTF-8"

      ### XDG ###
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_STATE_HOME="$HOME/.local/state"
      export XDG_CACHE_HOME="$HOME/.cache"

      export ZDOTDIR=$XDG_CONFIG_HOME/zsh

      typeset -U path fpath PATH

      path=(
        "$HOME/.local/bin"(N-/)
        "$HOME/go/bin"(N-/) # for golang
        "$HOME/.cargo/bin"(N-/) # for rust
        "$path[@]"
      )
    '';
    profileExtra = ''
      case $OSTYPE in
      darwin*)
        if [[ $CPUTYPE == "arm64" ]]; then
          HOMEBREW_PREFIX="/opt/homebrew"
        else
          HOMEBREW_PREFIX="/usr/local"
        fi
        ;;
      linux*)
        HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
        ;;
      esac

      if [[ -d $HOMEBREW_PREFIX ]]; then
          eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
      else
          unset HOMEBREW_PREFIX
      fi
    '';
    initContent = lib.mkMerge [
      (lib.mkOrder 1000 ''
        (( $+commands[vivid] )) && export LS_COLORS=$(vivid generate iceberg-dark)

        zstyle ':completion:*' menu select
        zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion::complete:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        zstyle ':completion:*' group-name '''
        zstyle ':completion:*' verbose yes
        zstyle ':completion:*' completer _complete _approximate
        zstyle ':completion:*:approximate:*' max-errors 2 numeric
        zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
        zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
        zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
        zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

        autoload -Uz bracketed-paste-magic
        zle -N bracketed-paste bracketed-paste-magic

        autoload -Uz url-quote-magic
        zle -N self-insert url-quote-magic

        # TODO: change nix style
        case ''${OSTYPE} in
          darwin*)
            alias pbc='pbcopy'
            alias pbp='pbpaste'
            ;;
          linux*)
            if [[ "$(uname -r)" == *microsoft* ]]; then
              export BROWSER="pwsh.exe /c start"
              alias open="powershell.exe /c start"
              alias pbc='/mnt/c/WINDOWS/system32/clip.exe'
              alias pbp='/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0//powershell.exe -Command Get-Clipboard'
            else
              alias open='xdg-open'
              case ''${XDG_SESSION_TYPE} in
                'x11')
                  if (( $+commands[xclip] )); then
                    alias pbc='xclip -selection clipboard -in'
                    alias pbp='xclip -selection clipboard -out'
                  elif (( $+commands[xsel] )); then
                    alias pbc='xsel --clipboard --input'
                    alias pbp='xsel --clipboard --output'
                  else
                    # echo "No clipboard util command. Recommned installing clip or xsel"
                  fi
                  ;;
                'wayland')
                  alias pbc='wl-copy'
                  alias pbp='wl-paste'
                  ;;
              esac
            fi
            ;;
        esac
      '')
      (lib.mkOrder 1500 "[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local || true")
    ];
  };
  xdg.cacheFile."zsh/.keep".text = "";
}
