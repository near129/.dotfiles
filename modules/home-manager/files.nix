{ config, lib, ... }:
let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.sourceDirectory}/${path}";
  skillNames = builtins.attrNames (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir ../../.config/agents/skills)
  );
  mkSkillLinks =
    targetDir:
    lib.listToAttrs (
      map (
        name:
        lib.nameValuePair "${targetDir}/${name}" { source = mkSymlink ".config/agents/skills/${name}"; }
      ) skillNames
    );
in
{
  options.dotfiles.sourceDirectory = lib.mkOption {
    type = lib.types.str;
    default = "${config.xdg.configHome}/dotfiles";
    description = "Absolute path to the local dotfiles checkout used by out-of-store links.";
  };

  config = {
    assertions = [
      {
        assertion = lib.hasPrefix "/" config.dotfiles.sourceDirectory;
        message = "dotfiles.sourceDirectory must be an absolute path.";
      }
    ];
    xdg = {
      enable = true;
      configFile = {
        "aerospace".source = mkSymlink ".config/aerospace";
        "alacritty".source = mkSymlink ".config/alacritty";
        "fish/config.fish".source = mkSymlink ".config/fish/config.fish";
        "fish/completions".source = mkSymlink ".config/fish/completions";
        "fish/functions".source = mkSymlink ".config/fish/functions";
        "fish/conf.d/notification.fish".source = mkSymlink ".config/fish/conf.d/notification.fish";
        "ghostty".source = mkSymlink ".config/ghostty";
        "karabiner/karabiner.json".source = mkSymlink ".config/karabiner/karabiner.json";
        "nvim".source = mkSymlink ".config/nvim";
        "opencode".source = mkSymlink ".config/opencode";
        "pnpm".source = mkSymlink ".config/pnpm";
        "starship.toml".source = mkSymlink ".config/starship.toml";
        "tmux".source = mkSymlink ".config/tmux";
        "uv".source = mkSymlink ".config/uv";
        "wezterm".source = mkSymlink ".config/wezterm";
        "zellij".source = mkSymlink ".config/zellij";
      };
    };
    home = {
      file = lib.mkMerge [
        (mkSkillLinks ".claude/skills")
        (mkSkillLinks ".agents/skills")
        (mkSkillLinks ".copilot/skills")
        {
          ".claude/CLAUDE.md".source = mkSymlink ".config/agents/AGENTS.md";
          ".claude/settings.json".source = mkSymlink ".config/claude/settings.json";
          ".claude/statusline.sh".source = mkSymlink ".config/claude/statusline.sh";
          ".claude/hook-notify.sh".source = mkSymlink ".config/claude/hook-notify.sh";
          ".codex/AGENTS.md".source = mkSymlink ".config/agents/AGENTS.md";
          ".codex/rules".source = mkSymlink ".config/codex/rules";
          ".copilot/copilot-instructions.md".source = mkSymlink ".config/agents/AGENTS.md";
        }
      ];
    };
  };
}
