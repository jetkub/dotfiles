-- jellybeans colorscheme configuration

require("jellybeans").setup({
  transparent = false,
  italics     = true,
  bold        = true,
  flat_ui     = false,
  background = {
    dark  = "jellybeans-default",
    light = "jellybeans-light"
  },
  plugins = {
    all  = false,
    auto = true,
  },
  on_highlights = function(hl, c)
    -- Parse hex color brightness (0–255 average of R, G, B)
    -- I can't rely on vim.o.background value to determine if
    -- colorscheme is dark 
    local function brightness(hex)
      hex = hex:gsub("^#", "")
      local r = tonumber(hex:sub(1, 2), 16)
      local g = tonumber(hex:sub(3, 4), 16)
      local b = tonumber(hex:sub(5, 6), 16)
      return (r + g + b) / 3
    end

    if brightness(c.background) < 128 then
      -- Active statusline: dark text on off-white, italic
      hl.StatusLine   = { fg = "#111111", bg = "#dddddd", italic = true }
      -- Inactive statusline: white text on dark purple-grey, italic
      hl.StatusLineNC = { fg = "#ffffff", bg = "#403c41", italic = true }
      -- Slightly thicker (bold) and brighter split divider
      hl.WinSeparator = { fg = "#454545", bold = true }
      -- Mode text, e.g. -- INSERT --
      hl.ModeMsg      = { fg = "#fadd76", italic = true }
    end
    -- Light colorschemes
    if brightness(c.background) > 128 then
      hl.StatusLine   = { fg = "#eeeeee", bg = "#605c61", italic = true }
      hl.StatusLineNC = { fg = "#434343", bg = "#ecd4be", italic = true }
      hl.WinSeparator = { fg = "#dcc4ae", bold = true }
      hl.ModeMsg      = { fg = "#5c8440", italic = true }
    end
  end,
})
