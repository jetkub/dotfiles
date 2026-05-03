local Util = require("jellybeans.util")

local M = {}

---@param c Palette
---@param opts jellybeans.Config
function M.get(c, opts)
  return {
    DressingInputNormal = { bg = opts.transparent and "NONE" or c.background, fg = c.foreground },
    DressingInputBorder = { fg = c.float_border },
    DressingInputTitle = { fg = c.biloba_flower, bold = opts.bold },
    DressingSelectNormal = { bg = opts.transparent and "NONE" or c.background, fg = c.foreground },
    DressingSelectBorder = { fg = c.float_border },
    DressingSelectTitle = { fg = c.biloba_flower, bold = opts.bold },
  }
end

return M