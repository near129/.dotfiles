return {
  settings = {
    nixd = {
      nixpkgs = {
        expr = 'import <nixpkgs> { }',
      },
      formatting = {
        command = { 'nixfmt' },
      },
      options = {
        nix_darwin = {
          expr = '(builtins.getFlake ("git+file://" + toString ./../../../..)).darwinConfigurations.near129.options',
        },
        home_manager = {
          expr = '(builtins.getFlake ("git+file://" + toString ./../../../..)).homeConfigurations."near129".options',
        },
      },
    },
  },
}
