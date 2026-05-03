local Util = require("jellybeans.util")

local M = {}

function M.get(c, opts)
  return {
    Bold = { bold = opts.bold },
    Comment = { fg = c.grey, italic = opts.italics },
    Constant = { fg = c.raw_sienna },
    Define = { fg = c.ship_cove },
    Delimiter = { fg = c.hoki },
    Error = { bg = c.error },
    Exception = { fg = c.wewak },
    Function = { fg = Util.lighten(c.goldenrod, 0.9) },
    Identifier = { fg = c.foreground },
    Include = { fg = c.perano, italic = opts.italics },
    Italic = { italic = opts.italics },
    Operator = { fg = c.perano },
    PreProc = { fg = c.ship_cove },
    Property = { fg = c.foreground },
    Special = { fg = c.biloba_flower },
    SpecialChar = { fg = c.raw_sienna },
    Statement = { fg = c.morning_glory },
    String = { fg = c.green_smoke },
    Structure = { fg = c.morning_glory },
    Todo = { fg = c.silver },
    Type = { fg = c.koromiko, italic = opts.italics },
    Underlined = { undercurl = true },
    Variable = { fg = c.alto },

    -- LSP
    LspDiagnosticsDefaultError = { fg = c.error },
    LspDiagnosticsDefaultWarning = { fg = c.koromiko },
    LspDiagnosticsDefaultInformation = { fg = c.perano },
    LspDiagnosticsDefaultHint = { fg = c.tea_green },
    LspReferenceRead = { bg = c.cocoa_brown },
    LspReferenceWrite = { bg = c.cocoa_brown },
    LspReferenceText = { bg = c.cocoa_brown },
    LspSignatureActiveParameter = { fg = c.warning },

    -- HTML
    htmlTag = { fg = c.grey_chateau },
    htmlEndTag = { fg = c.grey_chateau },
    htmlTagName = { fg = c.morning_glory },
    htmlArg = { fg = c.wewak },
    htmlTitle = { fg = c.foreground },
    htmlSpecialTagName = { fg = c.brandy },
    htmlLink = { fg = c.perano, underline = true },
    htmlSpecialChar = { fg = c.goldenrod },

    -- Markdown
    RenderMarkdownCodeInline = { bg = c.background, fg = c.koromiko },
    RenderMarkdownH1Bg = { bg = c.background, fg = c.perano },
    RenderMarkdownH2Bg = { bg = c.background, fg = c.biloba_flower },
    RenderMarkdownH3Bg = { bg = c.background, fg = c.tea_green },
    RenderMarkdownH4Bg = { bg = c.background, fg = c.raw_sienna },
    RenderMarkdownH5Bg = { bg = c.background, fg = c.wewak },
    RenderMarkdownH6Bg = { bg = c.background, fg = c.brandy },
  }
end

return M
