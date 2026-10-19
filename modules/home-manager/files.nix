{ config, lib, ... }:
let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${config.dotfiles.sourceDirectory}/${path}";
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
      file = {
        ".claude/CLAUDE.md".source = mkSymlink ".config/agents/AGENTS.md";
        ".claude/skills".source = mkSymlink ".config/agents/skills";
        ".agents/skills".source = mkSymlink ".config/agents/skills";
        ".claude/agents".source = mkSymlink ".config/claude/agents";
        ".claude/settings.json".source = mkSymlink ".config/claude/settings.json";
        ".claude/statusline.sh".source = mkSymlink ".config/claude/statusline.sh";
        ".claude/hook-notify.sh".source = mkSymlink ".config/claude/hook-notify.sh";
        ".codex/AGENTS.md".source = mkSymlink ".config/agents/AGENTS.md";
        ".codex/rules".source = mkSymlink ".config/codex/rules";
        ".copilot/copilot-instructions.md".source = mkSymlink ".config/agents/AGENTS.md";
        ".copilot/skills".source = mkSymlink ".config/agents/skills";
      };
    };
  };
}
