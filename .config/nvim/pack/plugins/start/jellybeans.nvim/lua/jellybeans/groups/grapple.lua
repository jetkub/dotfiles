local Util = require("jellybeans.util")

local M = {}

function M.get(c, opts)
  return {
    GrappleBold = { bold = opts.bold },
    GrappleHint = { fg = c.gray },
    GrappleName = { fg = c.perano },
    GrappleNoExist = { fg = c.error },
    GrappleCurrent = { fg = c.koromiko, bold = opts.bold },
    GrappleFloat = { bg = c.background },
    GrappleBorder = { fg = c.background },
    GrappleTitle = { fg = c.perano },
    GrappleFooter = { fg = c.biloba_flower },
  }
end

return M
