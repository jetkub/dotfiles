local M = {}

function M.get(c, opts)
  local is_mono = opts.palette_name and opts.palette_name:find("mono") ~= nil

  local normal_bg = is_mono and c.accent_color_2 or c.morning_glory
  local insert_bg = is_mono and c.accent_color_1 or c.green_smoke
  local visual_bg = is_mono and c.grey_chateau or c.koromiko
  local replace_bg = is_mono and c.boulder or c.raw_sienna
  local command_bg = is_mono and c.silver or c.biloba_flower

  return {
    -- Mini.statusline
    MiniStatuslineModeNormal = { fg = c.total_black, bg = normal_bg, bold = opts.bold },
    MiniStatuslineModeInsert = { fg = c.total_black, bg = insert_bg, bold = opts.bold },
    MiniStatuslineModeVisual = { fg = c.total_black, bg = visual_bg, bold = opts.bold },
    MiniStatuslineModeReplace = { fg = c.total_black, bg = replace_bg, bold = opts.bold },
    MiniStatuslineModeCommand = { fg = c.total_black, bg = command_bg, bold = opts.bold },
    MiniStatuslineModeOther = { fg = c.total_black, bg = c.grey_chateau, bold = opts.bold },

    MiniStatuslineDevinfo = { fg = c.foreground, bg = c.grey_one },
    MiniStatuslineFilename = { fg = c.grey_two, bg = c.background },
    MiniStatuslineFileinfo = { fg = c.foreground, bg = c.grey_one },
    MiniStatuslineInactive = { fg = c.grey, bg = c.background },
  }
end

return M