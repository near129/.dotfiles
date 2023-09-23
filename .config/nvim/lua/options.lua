vim.opt.number = true         -- Show line numbers
vim.opt.wildmenu = true       -- Enhance command line completion
vim.opt.showcmd = true        -- Display commands at the bottom of the screen
vim.opt.wrap = true           -- Enable line wrapping for long lines
vim.opt.textwidth = 0         -- Disable automatic line wrapping
vim.opt.cursorline = true     -- Highlight the current cursor line
vim.opt.visualbell = false    -- Disable visual bell
vim.opt.foldmethod = "indent" -- Set folding method to 'indent'
vim.opt.foldlevel = 99        -- Do not fold when opening files

-- Editing settings
vim.opt.infercase = true                         -- Ignore case during completion
vim.opt.hidden = true                            -- Keep buffers hidden when closed (for preserving undo history)
vim.opt.switchbuf = "useopen"                    -- Use already open buffers instead of creating new ones
vim.opt.autoindent = true                        -- Preserve auto-indentation when starting a new line
vim.opt.tabstop = 4                              -- Set the width of a tab character
vim.opt.shiftwidth = 4                           -- Set the width of an indent
vim.opt.expandtab = true                         -- Use spaces instead of tabs for indentation
vim.opt.shiftround = true                        -- Round indentation to a multiple of 'shiftwidth'
vim.opt.nrformats = "alpha"                      -- Use alphabetical format for numbering
vim.opt.backspace = { "indent", "eol", "start" } -- Allow backspace to delete various characters
vim.opt.clipboard = "unnamedplus"                -- Use system clipboard (if available) for copying and pasting

-- Search settings
vim.opt.ignorecase = true    -- Ignore case in searches
vim.opt.smartcase = true     -- Smart case sensitivity (case-sensitive if uppercase letters are used in the search query)
vim.opt.incsearch = true     -- Enable incremental search
vim.opt.hlsearch = true      -- Highlight search matches

vim.opt.splitbelow = true    -- Split new windows below the current one
vim.opt.splitright = true    -- Split new windows to the right of the current one
vim.opt.mouse = "a"          -- Enable mouse support
vim.opt.termguicolors = true -- Enable true color support in the terminal

-- Configure invisible characters display
vim.opt.list = true
vim.opt.listchars = { tab = "»-", trail = "-", eol = "↲", extends = "»", precedes = "«", nbsp = "%" }

-- Disable IME in insert mode
vim.opt.iminsert = 0

