local Util = require("jellybeans.util")

local M = {}

function M.get(c, opts)
  return {
    CopilotChatSpinner = {
      fg = c.cadet_blue,
    },
    CopilotChatHelp = {
      fg = c.cadet_blue,
    },
    CopilotChatHeader = {
      fg = c.biloba_flower,
    },
    CopilotChatSeparator = {
      fg = c.biloba_flower,
    },
  }
end

return M
