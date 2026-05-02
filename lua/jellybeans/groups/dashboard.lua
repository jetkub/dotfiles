local Util = require("jellybeans.util")

local M = {}

function M.get(c, opts)
  return {
    DashboardHeader = { fg = c.perano },
    DashboardCenter = { fg = c.morning_glory },
    DashboardFooter = { fg = c.grey },
    DashboardKey = { fg = c.goldenrod },
    DashboardDesc = { fg = c.biloba_flower },
    DashboardIcon = { fg = c.goldenrod },
    DashboardProjectTitle = { fg = c.perano, bold = opts.bold },
    DashboardProjectTitleIcon = { fg = c.morning_glory },
    DashboardProjectIcon = { fg = c.morning_glory },
    DashboardMruTitle = { fg = c.perano, bold = opts.bold },
    DashboardMruIcon = { fg = c.morning_glory },
    DashboardFiles = { fg = c.foreground },
    DashboardShortCut = { fg = c.koromiko },
  }
end

return M
