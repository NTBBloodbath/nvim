--- utils.lua - Utilities
--
-- Author:  NTBBloodbath <bloodbathalchemist@protonmail.com>
-- URL:     https://github.com/NTBBloodbath/nvim
-- License: GPLv3
--
--- Code:
local utils = {}

-- Stole it from tjdevries' lazy.nvim plugin as I didn't know
-- how to port my lazy-require! fennel macro to Lua (how the turntables)
utils.lazy_require = function(module)
	return setmetatable({}, {
		__index = function(_, key)
			return require(module)[key]
		end,

		__newindex = function(_, key, value)
			require(module)[key] = value
		end,
	})
end

return utils

--- utils.lua ends here
