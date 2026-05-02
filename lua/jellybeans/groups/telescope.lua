local Util = require("jellybeans.util")

local M = {}

---@param c Palette
---@param opts jellybeans.Config
function M.get(c, opts)
  local flat_hl = {}
  if opts.flat_ui then
    local prompt = c.mine_shaft
    flat_hl = {
      TelescopeNormal = { bg = c.background, fg = c.grey_two },
      TelescopeBorder = { bg = c.background, fg = c.background },
      TelescopePromptNormal = { bg = prompt },
      TelescopePromptBorder = { bg = prompt, fg = prompt },
      TelescopePromptPrefix = { bg = prompt },
      TelescopePromptCounter = { bg = prompt },
      TelescopePreviewBorder = { bg = c.background, fg = c.background },
      TelescopeResultsBorder = { bg = c.background, fg = c.background },
      TelescopePromptTitle = { bg = c.biloba_flower, fg = prompt },
      TelescopePreviewTitle = { bg = c.wewak, fg = prompt },
      TelescopeResultsTitle = { bg = c.koromiko, fg = prompt },
    }
  end

  return vim.tbl_extend("keep", flat_hl, {
    TelescopeNormal = { bg = opts.transparent and "NONE" or c.background },
    TelescopePromptNormal = { bg = opts.transparent and "NONE" or c.background },
    TelescopeResultsNormal = { bg = opts.transparent and "NONE" or c.background },
    TelescopePreviewNormal = { bg = opts.transparent and "NONE" or c.background },
    TelescopePromptBorder = { fg = c.grey_three, bg = c.background },
    TelescopeResultsBorder = { fg = c.grey_three, bg = c.background },
    TelescopePreviewBorder = { fg = c.grey_three, bg = c.background },
    TelescopePromptPrefix = { fg = c.koromiko, bg = c.background },
    TelescopePromptTitle = { fg = c.background, bg = c.koromiko },
    TelescopeResultsTitle = { bg = c.perano, fg = c.background, bold = opts.bold },
    TelescopePreviewTitle = { bg = c.wewak, fg = c.background, bold = opts.bold },
    TelescopeSelection = { bg = c.grey_one, fg = c.foreground },
    TelescopeSelectionCaret = { fg = c.koromiko, bg = c.grey_one },
    TelescopeMultiSelection = { bg = c.grey_one },
    TelescopeMatching = { fg = c.koromiko, bold = opts.bold },
    TelescopePromptCounter = { fg = c.grey, bg = c.background },
  })
end

return M
