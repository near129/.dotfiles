{ lib, ... }:
{
  programs.codex = {
    enable = true;
    mutableSettings = true;
    settings = lib.importTOML ../../../.config/codex/config.toml;
  };
}
