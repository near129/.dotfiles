{ config, ... }: {
  homebrew = {
    enable = true;
    onActivation = {
      extraEnv.XDG_CONFIG_HOME = "${config.users.users.${config.system.primaryUser}.home}/.config";
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    taps = [
      "nikitabobko/tap"
      "k1LoW/tap"
    ];
  };
}
