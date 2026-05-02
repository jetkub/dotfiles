local Util = require("jellybeans.util")

local M = {}

function M.get(c, opts)
  return {
    BlinkCmpDoc = {
      bg = opts.flat_ui and c.grey_three or c.background,
      fg = c.perano,
    },
    BlinkCmpDocBorder = opts.flat_ui
      and { bg = c.grey_three, fg = c.grey_three }
      or { bg = c.background, fg = c.float_border },
    BlinkCmpGhostText = {
      link = "Comment",
    },
    BlinkCmpDocSeparator = {
      bg = opts.flat_ui and c.grey_three or c.background,
      fg = opts.flat_ui and c.biloba_flower or c.float_border,
    },
    BlinkCmpKindArray = "LspKindArray",
    BlinkCmpKindBoolean = "LspKindBoolean",
    BlinkCmpKindClass = "LspKindClass",
    BlinkCmpKindCodeium = {
      bg = "NONE",
      fg = c.biloba_flower,
    },
    BlinkCmpKindColor = "LspKindColor",
    BlinkCmpKindConstant = "LspKindConstant",
    BlinkCmpKindConstructor = "LspKindConstructor",
    BlinkCmpKindCopilot = {
      bg = "NONE",
      fg = c.biloba_flower,
    },
    BlinkCmpKindDefault = {
      bg = "NONE",
      fg = c.biloba_flower,
    },
    BlinkCmpKindEnum = "LspKindEnum",
    BlinkCmpKindEnumMember = "LspKindEnumMember",
    BlinkCmpKindEvent = "LspKindEvent",
    BlinkCmpKindField = "LspKindField",
    BlinkCmpKindFile = "LspKindFile",
    BlinkCmpKindFolder = "LspKindFolder",
    BlinkCmpKindFunction = "LspKindFunction",
    BlinkCmpKindInterface = "LspKindInterface",
    BlinkCmpKindKey = "LspKindKey",
    BlinkCmpKindKeyword = "LspKindKeyword",
    BlinkCmpKindMethod = "LspKindMethod",
    BlinkCmpKindModule = "LspKindModule",
    BlinkCmpKindNamespace = "LspKindNamespace",
    BlinkCmpKindNull = "LspKindNull",
    BlinkCmpKindNumber = "LspKindNumber",
    BlinkCmpKindObject = "LspKindObject",
    BlinkCmpKindOperator = "LspKindOperator",
    BlinkCmpKindPackage = "LspKindPackage",
    BlinkCmpKindProperty = "LspKindProperty",
    BlinkCmpKindReference = "LspKindReference",
    BlinkCmpKindSnippet = "LspKindSnippet",
    BlinkCmpKindString = "LspKindString",
    BlinkCmpKindStruct = "LspKindStruct",
    BlinkCmpKindSupermaven = {
      bg = "NONE",
      fg = c.biloba_flower,
    },
    BlinkCmpKindTabNine = {
      bg = "NONE",
      fg = c.biloba_flower,
    },
    BlinkCmpKindText = "LspKindText",
    BlinkCmpKindTypeParameter = "LspKindTypeParameter",
    BlinkCmpKindUnit = "LspKindUnit",
    BlinkCmpKindValue = "LspKindValue",
    BlinkCmpKindVariable = "LspKindVariable",
    BlinkCmpLabel = {
      bg = "NONE",
      fg = c.raw_sienna,
    },
    BlinkCmpLabelDeprecated = {
      bg = "NONE",
      fg = c.hoki,
      strikethrough = true,
    },
    BlinkCmpLabelMatch = {
      bg = "NONE",
      fg = c.morning_glory,
    },
    BlinkCmpMenu = {
      bg = opts.flat_ui and c.grey_three or c.background,
      fg = c.biloba_flower,
    },
    BlinkCmpMenuBorder = opts.flat_ui
      and { bg = c.grey_three, fg = c.grey_three }
      or { bg = c.background, fg = c.float_border },
    BlinkCmpSignatureHelp = {
      bg = opts.flat_ui and c.grey_three or c.background,
      fg = c.biloba_flower,
    },
    BlinkCmpSignatureHelpBorder = opts.flat_ui
      and { bg = c.grey_three, fg = c.grey_three }
      or { bg = c.background, fg = c.float_border },
  }
end

return M
