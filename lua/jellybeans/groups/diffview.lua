local M = {}

function M.get(c, opts)
  return {
    DiffViewDiffAdd = { fg = c.git.add.fg, bg = c.grey_three },
    DiffViewDiffDelete = { fg = c.git.delete.fg, bg = c.grey_three },
    DiffViewDiffChange = { fg = c.git.change.fg, bg = c.grey_three },
    DiffviewDiffText = { bg = c.shuttle_grey },
    DiffviewFilePanelTitle = { fg = c.biloba_flower, bold = opts.bold },
    DiffviewFilePanelCounter = { fg = c.grey_chateau },
    DiffviewFilePanelFileName = { fg = c.foreground },
    DiffviewFolderSign = { fg = c.morning_glory },
  }
end

return M
