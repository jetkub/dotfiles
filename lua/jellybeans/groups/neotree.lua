local Util = require("jellybeans.util")

local M = {}

function M.get(c, opts)
  return {
    NeoTreeDirectoryName = { fg = c.morning_glory },
    NeoTreeDirectoryIcon = { fg = c.morning_glory },
    NeoTreeRootName = { fg = c.goldenrod, bold = opts.bold },
    NeoTreeFileName = { fg = c.foreground },
    NeoTreeFileIcon = { fg = c.morning_glory },
    NeoTreeFileNameOpened = { fg = c.perano },
    NeoTreeIndentMarker = { fg = c.grey_three },
    NeoTreeGitAdded = { fg = c.mantis },
    NeoTreeGitConflict = { fg = c.old_brick },
    NeoTreeGitDeleted = { fg = c.old_brick },
    NeoTreeGitIgnored = { fg = c.grey },
    NeoTreeGitModified = { fg = c.koromiko },
    NeoTreeGitUnstaged = { fg = c.koromiko },
    NeoTreeGitUntracked = { fg = c.raw_sienna },
    NeoTreeGitStaged = { fg = c.tea_green },
    NeoTreeFloatBorder = { bg = c.background, fg = c.background },
    NeoTreeFloatTitle = { bg = c.total_black, fg = c.foreground },
    NeoTreeDimText = { link = "Comment" },
  }
end

return M
