local options = {}
if vim.env.NIXD_SYSTEM_OPTIONS_EXPR then
  options.system = { expr = vim.env.NIXD_SYSTEM_OPTIONS_EXPR }
end
if vim.env.NIXD_HOME_OPTIONS_EXPR then
  options.home_manager = { expr = vim.env.NIXD_HOME_OPTIONS_EXPR }
end

return {
  settings = {
    nixd = {
      nixpkgs = vim.env.NIXD_NIXPKGS_EXPR and { expr = vim.env.NIXD_NIXPKGS_EXPR } or nil,
      formatting = {
        command = { 'nixfmt' },
      },
      options = options,
    },
  },
}
