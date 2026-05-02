local Util = require("jellybeans.util")

local M = {}

---@param c Palette
---@param opts jellybeans.Config
local function get_flat_hl(c, opts)
  return {
    WhichKeyBorder = {
      bg = opts.transparent and "NONE" or c.background,
      fg = c.background,
    },
  }
end

---@param c Palette
---@param opts jellybeans.Config
function M.get(c, opts)
  local flat_hl = {}
  if opts.flat_ui then
    flat_hl = get_flat_hl(c, opts)
  end
  return vim.tbl_extend("keep", flat_hl, {
    WhichKey = { bg = opts.transparent and "NONE" or c.background },
    WhichKeyNormal = { bg = opts.transparent and "NONE" or c.background },
    WhichKeyBorder = {
      bg = opts.transparent and "NONE" or c.background,
      fg = c.biloba_flower,
    },
    WhichKeyDesc = { bg = opts.transparent and "NONE" or c.background, fg = c.wewak },
    WhichKeyGroup = { bg = opts.transparent and "NONE" or c.background, fg = c.biloba_flower },
    WhichKeyIcon = { bg = opts.transparent and "NONE" or c.background },
    WhichKeySeparator = { bg = opts.transparent and "NONE" or c.background, fg = c.morning_glory },
    WhichKeyTitle = { bg = opts.transparent and "NONE" or c.background, fg = c.biloba_flower },
    WhichKeyValue = { bg = opts.transparent and "NONE" or c.background, fg = c.morning_glory },
  })
end

return M
