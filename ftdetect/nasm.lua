vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.s", "*.asm" },
	callback = function()
    -- see ':h ft-nasm-syntax'
	  vim.b.asmsyntax = "nasm"
	  -- proper NASM syntax
	  vim.opt_local.filetype = "nasm"
	end,
})
