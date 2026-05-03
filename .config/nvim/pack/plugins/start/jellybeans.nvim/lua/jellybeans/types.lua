---@class jellybeans.Highlight: vim.api.keyset.highlight
---@field style? vim.api.keyset.highlight

---@alias jellybeans.Highlights table<string,jellybeans.Highlight|string>

---@alias jellybeans.HighlightsFn fun(colors: ColorScheme, opts:jellybeans.Config):jellybeans.Highlights
