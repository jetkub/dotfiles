local Util = require("jellybeans.util")

---@class Palette
-- Warm dark variant: amber/espresso neutrals, vibrant accent colors unchanged
local palette = {
  foreground = "#edd9b8",
  background = "#1c1510",

  grey = "#8a8070",
  grey_one = "#241a10",
  grey_two = "#f0e4d0",
  grey_three = "#352519",
  regent_grey = "#9a9088",
  scorpion = "#665850",
  cod_grey = "#141008",
  tundora = "#4a3828",
  zambezi = "#6a5a50",
  silver_rust = "#d0c0a8",
  silver = "#c8b898",
  alto = "#e0cebc",
  gravel = "#3c2c1c",
  boulder = "#7a6a58",
  cocoa_brown = "#302028",
  grey_chateau = "#a09080",
  bright_grey = "#3c3028",
  shuttle_grey = "#5a4e42",
  mine_shaft = "#281e14",
  temptress = "#40000a",
  bayoux_blue = "#5a5038",
  total_white = "#ffffff",
  total_black = "#000000",
  cadet_blue = "#b0a090",
  perano = "#c8b878",
  wewak = "#cc88a3",
  mantis = "#70b950",
  raw_sienna = "#d98870",
  highland = "#799d6a",
  hoki = "#668799",
  green_smoke = "#99ad6a",
  costa_del_sol = "#556633",
  biloba_flower = "#c6b6ee",
  morning_glory = "#8fbfdc",
  goldenrod = "#fad07a",
  ship_cove = "#8197bf",
  koromiko = "#e6a75a",
  brandy = "#dad085",
  old_brick = "#902020",
  dark_blue = "#0000df",
  ripe_plum = "#540063",
  casal = "#2D7067",
  purple = "#700089",
  tea_green = "#d2ebbe",
  dell = "#437019",
  calypso = "#2B5B77",

  error = "#d74545",
  warning = "#ffaf00",
  info = "#5f9ecf",
  hint = "#a08070",
  ok = "#afd787",
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
  name = "jellybeans_warm",
  style = "dark",
  palette = palette,
}
