--- pairs.lua - Dead simple autopairs
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:

local pairs = {}

local function should_delete(text)
	return vim.tbl_contains({ "{", "[", "(", "<", '"', "'", "`" }, text)
end

local function should_escape(text)
	return vim.tbl_contains({ "}", "]", ")", ">", '"', "'" }, text)
end

local function get_pair(text)
	local pairs_tbl = {
		["{"] = "}",
		["["] = "]",
		["("] = ")",
		["<"] = ">",
		['"'] = '"',
		["'"] = "'",
		["`"] = "`",
	}
	return pairs_tbl[text]
end

local function delete_and_deindent()
	local col = vim.fn.getpos(".")[3]

	local cursor_line = vim.api.nvim_get_current_line()
	local prev_char = cursor_line:sub(col - 1, col - 1)
	local curr_char = cursor_line:sub(col, col)

	if should_delete(prev_char) and curr_char == get_pair(prev_char) then
	  vim.keymap.set("i", "<BS>", '<ESC>"_2s')
	  vim.keymap.set("i", "<Enter>", "<Enter><ESC>O")
	else
	  vim.keymap.set("i", "<BS>", "<BS>")
	  vim.keymap.set("i", "<Enter>", "<Enter>")
	end
end

local function escape()
	local col = vim.fn.getpos(".")[3]

	local cursor_line = vim.api.nvim_get_current_line()
	local kbd_input = cursor_line:sub(col - 1, col - 1)
	local curr_char = cursor_line:sub(col, col)

  if kbd_input ~= curr_char then
    if kbd_input == '"' then
      vim.api.nvim_command('normal i"')
    elseif input == "'" then
      vim.api.nvim_command("normal i'")
    end
  end

  if should_escape(input) and input == curr_char then
    vim.api.nvim_command('normal "_x')
    if col == cursor_line:len() then
      vim.api.nvim_command("startinsert!")
    end
  end
end

pairs.setup = function()
  vim.keymap.set("i", "{", "{}<ESC>i")
  vim.keymap.set("i", "[", "[]<ESC>i")
  vim.keymap.set("i", "(", "()<ESC>i")
  vim.keymap.set("i", '"', '""<ESC>i')
  vim.keymap.set("i", "'", "''<ESC>i")
  vim.keymap.set("i", "`", "``<ESC>i")

  vim.api.nvim_create_augroup("Pairs", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = "Pairs",
    pattern = "*",
    callback = delete_and_deindent,
  })
  vim.api.nvim_create_autocmd("TextChangedI", {
    group = "Pairs",
    pattern = "*",
    callback = escape,
  })
end

return pairs

--- pairs.lua
