local Util = require("jellybeans.util")

local M = {}

---@param c Palette
---@param opts jellybeans.Config
function M.get(c, opts)
  return {
    -- Main trouble window
    TroubleNormal = { bg = opts.transparent and "NONE" or c.background, fg = c.foreground },
    TroubleNormalNC = { bg = opts.transparent and "NONE" or c.background, fg = c.foreground },
    TroubleText = { fg = c.foreground },
    TroubleCount = { fg = c.biloba_flower, bg = c.grey_one, bold = opts.bold },
    TroubleIndent = { fg = c.grey_three },
    TroubleFoldIcon = { fg = c.perano },

    -- File headers
    TroubleFile = { fg = c.morning_glory, bold = opts.bold },
    TroubleFileIcon = { fg = c.morning_glory },

    -- Source code locations
    TroubleLocation = { fg = c.grey },
    TroubleSource = { fg = c.wewak },

    -- Signs/Diagnostics
    TroubleCode = { fg = c.grey_two },
    TroubleSignError = { fg = c.old_brick },
    TroubleSignWarning = { fg = c.koromiko },
    TroubleSignInformation = { fg = c.perano },
    TroubleSignHint = { fg = c.mantis },
    TroubleTextError = { fg = c.old_brick },
    TroubleTextWarning = { fg = c.koromiko },
    TroubleTextInformation = { fg = c.perano },
    TroubleTextHint = { fg = c.mantis },

    -- Preview / current item
    TroublePreview = { fg = c.biloba_flower, bg = c.grey_one },
  }
end

return M
