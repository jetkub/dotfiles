local Util = require("jellybeans.util")

local M = {}

function M.get(c, opts)
  return {
    AvanteSidebarNormal = {
      bg = opts.transparent and "NONE" or c.background,
      fg = c.foreground,
    },
    AvanteSuggestion = {
      fg = c.regent_grey,
      italic = true,
    },
    AvanteAnnotation = {
      fg = c.regent_grey,
      italic = true,
    },
    AvantePopupHint = {
      bg = opts.transparent and "NONE" or c.grey_one,
      fg = c.foreground,
    },
    AvanteInlineHint = {
      fg = c.biloba_flower,
      bold = opts.bold,
    },
    AvanteToBeDeleted = {
      bg = c.temptress,
      fg = c.foreground,
      strikethrough = true,
    },
    AvanteToBeDeletedWOStrikethrough = {
      bg = c.temptress,
      fg = c.foreground,
    },
    AvanteConfirmTitle = {
      bg = opts.transparent and "NONE" or c.background,
      fg = c.morning_glory,
      bold = opts.bold,
    },
    AvanteCommentFg = {
      fg = c.regent_grey,
    },
    AvanteReversedNormal = {
      bg = c.foreground,
      fg = c.background,
    },
    AvantePromptInput = {
      bg = opts.transparent and "NONE" or c.grey_one,
      fg = c.foreground,
    },
    AvantePromptInputBorder = {
      fg = c.background,
    },
    AvanteSidebarWinSeparator = {
      bg = c.background,
      fg = c.background,
    },
    AvanteSidebarWinHorizontalSeparator = {
      bg = c.background,
      fg = c.background,
    },
    AvanteStateSpinnerGenerating = {
      fg = c.koromiko,
    },
    AvanteStateSpinnerToolCalling = {
      fg = c.biloba_flower,
    },
    AvanteStateSpinnerFailed = {
      fg = c.old_brick,
    },
    AvanteStateSpinnerSucceeded = {
      fg = c.mantis,
    },
    AvanteStateSpinnerSearching = {
      fg = c.cadet_blue,
    },
    AvanteStateSpinnerThinking = {
      fg = c.perano,
    },
    AvanteStateSpinnerCompacting = {
      fg = c.morning_glory,
    },
    AvanteConflictCurrent = {
      bg = c.temptress,
      fg = c.foreground,
    },
    AvanteConflictCurrentLabel = {
      bg = c.bright_grey,
      fg = c.foreground,
    },
    AvanteConflictIncoming = {
      bg = c.casal,
      fg = c.foreground,
    },
    AvanteConflictIncomingLabel = {
      bg = c.grey_three,
      fg = c.foreground,
    },
    AvanteFileSelectorNormal = {
      bg = opts.transparent and "NONE" or c.grey_three,
      fg = c.foreground,
    },
    AvanteFileSelectorBorder = {
      bg = opts.transparent and "NONE" or c.grey_three,
      fg = c.grey_one,
    },
    AvanteFileSelectorTitle = {
      bg = c.koromiko,
      fg = c.background,
      bold = opts.bold,
    },
    AvanteFileSelectorSelection = {
      bg = c.grey_one,
      fg = c.foreground,
    },
    AvanteFileSelectorCaret = {
      fg = c.koromiko,
      bg = c.grey_one,
    },
    AvanteFileSelectorMatching = {
      fg = c.koromiko,
      bold = opts.bold,
    },
    AvanteFileSelectorPrompt = {
      bg = opts.transparent and "NONE" or c.grey_three,
      fg = c.foreground,
    },
    AvanteFileSelectorCounter = {
      fg = c.grey,
      bg = opts.transparent and "NONE" or c.grey_three,
    },
  }
end

return M
