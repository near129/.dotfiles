{ lib, ... }:
{
  programs.codex = {
    enable = true;
    package = lib.mkDefault null;
    mutableSettings = true;
    settings = lib.importTOML ../../.config/codex/config.toml;
  };
}
