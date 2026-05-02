local Util = require("jellybeans.util")

local M = {}

function M.get(c, opts)
  return {
    GitSignsAdd = { fg = c.mantis },
    GitSignsChange = { fg = c.koromiko },
    GitSignsDelete = { fg = c.old_brick },
  }
end

return M
