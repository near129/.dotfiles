return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
    config = function(_, opts)
      -- The FileType autocmd only installs the `markdown` parser; inline elements (images, links) need `markdown_inline`
      require('nvim-treesitter').install({ 'markdown', 'markdown_inline' })
      require('render-markdown').setup(opts)
    end,
    opts = {
      -- Keep `#` markers as written
      heading = { enabled = false },
      -- No link icons
      link = { enabled = false },
    },
  },
  {
    'folke/snacks.nvim',
    ---@type snacks.Config
    opts = {
      -- Renders images via the kitty graphics protocol. SVG needs ImageMagick, mermaid needs mmdc (mermaid-cli)
      image = {},
    },
  },
}
