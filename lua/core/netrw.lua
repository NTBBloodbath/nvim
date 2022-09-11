--- netrw.lua - Saner netrw defaults
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

--- Configuration
--
-- Disable banner
vim.g.netrw_banner = 0

-- Keep the current directory and the broesing directory synced
-- NOTE: this helps to avoid the move files error
vim.g.netrw_keepdir = 1

-- Show directories first (sorting)
vim.g.netrw_sort_sequence = "[\\/]$,*"

-- Human-readable file size
vim.g.netrw_sizestyle = "H"

-- Tree view
vim.g.netrw_liststyle = 3

-- Hide files from .gitignore
vim.g.netrw_lis_hide = vim.fn["netrw_gitignore#Hide"]()

-- Show hidden files
vim.g.netrw_hide = 0

-- Chang the size of the Netrw window when it creates a split
vim.g.netrw_winsize = -25

-- Preview files in a vertical split window
vim.g.netrw_preview = 1

-- Open files in split (open previous window)
vim.g.netrw_browse_split = 4

-- Setup file operations commands (recursive operations)
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_localmkdir = "mkdir -p"
vim.g.netrw_localrmdir = "rm -r"

-- Highlight marked files in the same way search matches are
vim.api.nvim_set_hl(0, "netrwMarkFile", { link = "Search" })

--- netrw.lua ends here
