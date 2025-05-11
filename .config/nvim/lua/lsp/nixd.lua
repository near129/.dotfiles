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
          expr = '(builtins.getFlake ("git+file://" + toString ./../../../..)).darwinConfigurations.MacBook-Air.options',
        },
        home_manager = {
          expr = '(builtins.getFlake ("git+file://" + toString ./../../../..)).homeConfigurations."near129@MacBook-Air".options',
        },
      },
    },
  },
}
