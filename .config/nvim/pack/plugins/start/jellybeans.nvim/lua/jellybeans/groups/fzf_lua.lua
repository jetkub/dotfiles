local Util = require("jellybeans.util")
local M = {}

---@param c Palette
---@param opts jellybeans.Config
function M.get(c, opts)
  local flat_hl = {}
  if opts.flat_ui then
    local prompt = c.mine_shaft
    flat_hl = {
      FzfLuaNormal = { bg = c.background, fg = c.grey_two },
      FzfLuaBorder = { bg = c.background, fg = c.background },
      FzfLuaPromptNormal = { bg = prompt },
      FzfLuaPromptBorder = { bg = prompt, fg = prompt },
      FzfLuaPromptPrefix = { bg = prompt },
      FzfLuaPromptCounter = { bg = prompt },
      FzfLuaPreviewBorder = { bg = c.background, fg = c.background },
      FzfLuaResultsBorder = { bg = c.background, fg = c.background },
      FzfLuaTitle = { bg = c.perano, fg = c.background },
      FzfLuaPromptTitle = { bg = c.biloba_flower, fg = prompt },
      FzfLuaPreviewTitle = { bg = c.koromiko, fg = prompt },
      FzfLuaResultsTitle = { bg = c.koromiko, fg = prompt },
      FzfLuaCursor = { bg = c.grey_one, fg = c.foreground },
      FzfLuaSearch = { fg = c.koromiko, bold = opts.bold },
      FzfLuaScrollBorder = { fg = c.background },
      FzfLuaScrollFloatEmpty = { bg = c.background },
    }
  end

  return vim.tbl_extend("keep", flat_hl, {
    FzfLuaNormal = { bg = opts.transparent and "NONE" or c.background },
    FzfLuaPromptNormal = { bg = opts.transparent and "NONE" or c.background },
    FzfLuaResultsNormal = { bg = opts.transparent and "NONE" or c.background },
    FzfLuaPreviewNormal = { bg = opts.transparent and "NONE" or c.background },
    FzfLuaPromptBorder = { fg = c.grey_three, bg = c.background },
    FzfLuaResultsBorder = { fg = c.grey_three, bg = c.background },
    FzfLuaPreviewBorder = { fg = c.grey_three, bg = c.background },
    FzfLuaTitle = { bg = c.perano, fg = c.background },
    FzfLuaPromptPrefix = { fg = c.koromiko, bg = c.background },
    FzfLuaPromptTitle = { fg = c.background, bg = c.koromiko },
    FzfLuaResultsTitle = { bg = c.perano, fg = c.background, bold = opts.bold },
    FzfLuaPreviewTitle = { bg = c.koromiko, fg = c.background, bold = opts.bold },
    FzfLuaCursor = { bg = c.grey_one, fg = c.foreground },
    FzfLuaSearch = { fg = c.koromiko, bold = opts.bold },
    FzfLuaScrollBorder = { fg = c.grey_three },
    FzfLuaScrollFloatEmpty = { bg = c.background },
    FzfLuaHeaderBind = { fg = c.koromiko },
    FzfLuaHeaderText = { fg = c.grey_two },
    FzfLuaList = { fg = c.foreground },
    FzfLuaSelected = { bg = c.grey_one, fg = c.foreground },
    FzfLuaMatching = { fg = c.koromiko, bold = opts.bold },
  })
end

return M
