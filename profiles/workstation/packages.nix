{ pkgs, ... }: {
  home.packages = with pkgs; [
    awscli2
    claude-code
    ffmpeg
    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.cloud-run-proxy ])
    imagemagick
    k9s
    opencode
    pandoc
  ];
}
