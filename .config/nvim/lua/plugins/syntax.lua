return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = true,
    init = function(ctx)
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ctx)
          local lang = vim.treesitter.language.get_lang(ctx.match)
          if not vim.tbl_contains(require('nvim-treesitter').get_installed(), lang) then
            if vim.tbl_contains(require('nvim-treesitter').get_available(), lang) then
              require('nvim-treesitter').install({ lang }):await(function(err)
                if err then
                  vim.notify(err, vim.log.levels.ERROR, { title = 'nvim-treesitter' })
                end
              end)
            end
          end
          local ok = pcall(vim.treesitter.start, ctx.buf)
          if ok then
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldmethod = 'expr'
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-context', evnet = { 'BufNewFile', 'BufReadPre' } },
}
