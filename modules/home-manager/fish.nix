{ config, pkgs, ... }:
{
  xdg.configFile."fish/conf.d/hm-session-vars.fish".source =
    pkgs.runCommandLocal "hm-session-vars.fish" { }
      ''
        echo 'function setup_hm_session_vars' > "$out"
        ${pkgs.buildPackages.babelfish}/bin/babelfish \
          < ${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh >> "$out"
        echo 'end' >> "$out"
        echo 'setup_hm_session_vars' >> "$out"
        ${pkgs.buildPackages.fish}/bin/fish --no-config --no-execute "$out"
      '';
}
