local M = {}

function M.get(c, opts)
  return {
    RenderMarkdownH1 = { fg = c.biloba_flower, bold = opts.bold },
    RenderMarkdownH2 = { fg = c.morning_glory, bold = opts.bold },
    RenderMarkdownH3 = { fg = c.goldenrod, bold = opts.bold },
    RenderMarkdownH4 = { fg = c.green_smoke, bold = opts.bold },
    RenderMarkdownH5 = { fg = c.wewak, bold = opts.bold },
    RenderMarkdownH6 = { fg = c.raw_sienna, bold = opts.bold },
    RenderMarkdownH1Bg = { fg = c.perano },
    RenderMarkdownH2Bg = { fg = c.morning_glory },
    RenderMarkdownH3Bg = { fg = c.goldenrod },
    RenderMarkdownH4Bg = { fg = c.green_smoke },
    RenderMarkdownH5Bg = { fg = c.wewak },
    RenderMarkdownH6Bg = { fg = c.raw_sienna },
    RenderMarkdownCode = { bg = c.grey_one },
    RenderMarkdownCodeInline = { bg = c.grey_three, fg = c.koromiko },
    RenderMarkdownBullet = { fg = c.goldenrod },
    RenderMarkdownQuote = { fg = c.grey_chateau, italic = opts.italics },
    RenderMarkdownLink = { fg = c.morning_glory },
    RenderMarkdownDash = { fg = c.tundora },
    RenderMarkdownTableHead = { fg = c.biloba_flower, bold = opts.bold },
    RenderMarkdownTableRow = { fg = c.foreground },
    RenderMarkdownTableFill = { fg = c.tundora },
  }
end

return M
