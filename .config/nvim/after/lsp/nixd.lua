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
          expr = '(builtins.getFlake ("git+file://" + toString ./../../../..)).darwinConfigurations.napoli25.options',
        },
        home_manager = {
          expr = '(builtins.getFlake ("git+file://" + toString ./../../../..)).homeConfigurations.napoli25.options',
        },
      },
    },
  },
}
