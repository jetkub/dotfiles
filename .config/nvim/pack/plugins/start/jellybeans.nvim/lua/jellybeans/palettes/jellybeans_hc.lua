local Util = require("jellybeans.util")

---@class Palette
-- High contrast dark variant: near-black bg, near-white fg, boosted accent saturation
local palette = {
  foreground = "#f8f8f0",
  background = "#060606",

  grey = "#909090",
  grey_one = "#0e0e0e",
  grey_two = "#f8f8f8",
  grey_three = "#1a1a1a",
  regent_grey = "#98a0a8",
  scorpion = "#484848",
  cod_grey = "#040404",
  tundora = "#303030",
  zambezi = "#605958",
  silver_rust = "#e0d8d0",
  silver = "#d8d8d8",
  alto = "#f0f0f0",
  gravel = "#282828",
  boulder = "#686868",
  cocoa_brown = "#3a2030",
  grey_chateau = "#a8b0b8",
  bright_grey = "#303848",
  shuttle_grey = "#505d68",
  mine_shaft = "#111111",
  temptress = "#40000a",
  bayoux_blue = "#556779",
  total_white = "#ffffff",
  total_black = "#000000",
  cadet_blue = "#b8c0c8",
  perano = "#c0e0ff",
  wewak = "#e898b8",
  mantis = "#8cd468",
  raw_sienna = "#f0a080",
  highland = "#90b880",
  hoki = "#78a0b8",
  green_smoke = "#c0d880",
  costa_del_sol = "#6a7840",
  biloba_flower = "#d8c8ff",
  morning_glory = "#aad4f8",
  goldenrod = "#ffe080",
  ship_cove = "#98b0e0",
  koromiko = "#ffc060",
  brandy = "#f0e098",
  old_brick = "#b02020",
  dark_blue = "#0000ff",
  ripe_plum = "#680080",
  casal = "#3a8880",
  purple = "#8800a8",
  tea_green = "#e0f0c0",
  dell = "#559020",
  calypso = "#3070a0",

  error = "#ff5050",
  warning = "#ffc800",
  info = "#60b8ff",
  hint = "#c09070",
  ok = "#c0f060",
}

palette.cursor_line = {
  bg = Util.lighten(palette.background, 0.95),
}

palette.cursor_line_nr = {
  fg = palette.silver_rust,
}

palette.git = {
  add = { fg = palette.ok },
  delete = { fg = palette.error },
  change = { fg = palette.info },
  text = { fg = palette.hint },
}

palette.diag = {
  error = palette.error,
  warning = palette.warning,
  info = palette.info,
  hint = palette.hint,
  ok = palette.ok,
}

palette.visual = palette.tundora
palette.none = "NONE"

palette.float_bg = palette.gravel
palette.float_border = palette.tundora

return {
  name = "jellybeans_hc",
  style = "dark",
  palette = palette,
}
