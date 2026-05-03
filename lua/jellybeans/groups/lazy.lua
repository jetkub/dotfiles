local Util = require("jellybeans.util")

local M = {}

function M.get(c, opts)
  return {
    LazyNormal = { bg = opts.transparent and "NONE" or c.background, fg = c.alto },
    LazyButton = { bg = c.grey_three, fg = c.alto },
    LazyProgressDone = { bold = opts.bold, fg = c.raw_sienna },
    LazyProgressTodo = { bold = opts.bold, fg = c.ship_cove },
  }
end

return M
