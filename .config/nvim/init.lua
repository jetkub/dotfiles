-- LOAD CONFIG
-- require("")

require("jellybeans").setup({
  transparent = false,
  italics     = true,
  bold        = true,
  flat_ui     = false,
  background = {
      dark  = "jellybeans",
      light = "jellybeans-light"
  },
  plugins = {
    all  = false,
    auto = true,
  }
})

-- =============================================================================
-- OPTIONS
-- =============================================================================

vim.opt.number        = true
vim.opt.sidescrolloff = 2
vim.opt.display:append("truncate")
vim.opt.infercase     = true
vim.opt.ignorecase    = true
vim.opt.smartcase     = true
vim.opt.expandtab     = true
vim.opt.shiftwidth    = 4
vim.opt.tabstop       = 4
vim.opt.ruler         = true
vim.opt.number        = true
vim.opt.linebreak     = true

-- Colors 
vim.cmd.colorscheme('jellybeans-default')

-- Invisible characters shown with :set list
vim.opt.listchars = { tab = "▸ ", eol = "¬", space = "·", trail = "~", extends = ">", precedes = "<" }

-- Completion
vim.opt.pumheight    = 10
-- The new fuzzy mode has weird behavior. The first suggested completion does
-- not always match the case of the word I'm typing. Kind of annoying. Enable
-- again in the future; see if anything changes with fuzzy matching algorithm.
-- vim.opt.completeopt  = "fuzzy,menuone,noselect,popup"

vim.opt.completeopt  = "menuone,popup"
vim.opt.autocomplete = true 
-- vim.opt.completeopt  = "menuone,noinsert,popup"
-- vim.opt.autocomplete = false 

-- Wildmode controls tab-completion behavior in the command line
vim.opt.wildmenu    = true
vim.opt.wildoptions = "fuzzy,pum"
-- "longest:lastused,full:noselect" 
-- First <Tab>: completes up to the longest common prefix, 
-- sort by most recent for buffers
-- Second <Tab>: trigger completion popup, don't pre-select first item in list
vim.opt.wildmode    = "longest:lastused,full:noselect"

-- =============================================================================
-- KEYMAPS
-- =============================================================================

vim.g.mapleader = " "

-- Clear search highlight + redraw 
vim.keymap.set('n', '<C-L>', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', { silent = true })

-- Undo breakpoints in insert mode
vim.keymap.set('i', '<C-U>', '<C-G>u<C-U>', { noremap = true })
vim.keymap.set('i', '<C-W>', '<C-G>u<C-W>', { noremap = true })

-- Paste from system clipboard 
vim.keymap.set('n', '<Leader>p', '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set('n', '<Leader>P', '"+P', { desc = "Paste from system clipboard (before)" })

-- Surround word under cursor
-- TODO: think of a different way to handle this.
vim.keymap.set('n', '<Leader>*', 'ciw*<C-r>"*<Esc>', { noremap = true })
vim.keymap.set('n', '<Leader>"', 'ciw"<C-r>""<Esc>', { noremap = true })
vim.keymap.set('n', "<Leader>'", "ciw'<C-r>\"'<Esc>", { noremap = true })
vim.keymap.set('n', '<Leader>_', 'ciw_<C-r>"_<Esc>', { noremap = true })
vim.keymap.set('n', '<Leader>(', 'ciw(<C-r>")<Esc>', { noremap = true })
vim.keymap.set('n', '<Leader>[', 'ciw[<C-r>"]<Esc>', { noremap = true })
vim.keymap.set('n', '<Leader>{', 'ciw{<C-r>"}<Esc>', { noremap = true })

-- Readline-style command line
vim.keymap.set('c', '<C-a>', '<Home>', { noremap = true })
vim.keymap.set('c', '<C-e>', '<End>',  { noremap = true })
vim.keymap.set('c', '<C-p>', '<Up>',   { noremap = true })
vim.keymap.set('c', '<C-n>', '<Down>', { noremap = true })

-- Delete only whitespace before cursor up to but not including preceding word.
-- If there is only a single space before the cursor, behave like Ctrl+W
-- (delete the space + the preceding word) so you don't have to press twice.
local function SmartBackspace()
  local col = vim.fn.col('.') - 1
  local line = vim.fn.getline('.')
  local before = line:sub(1, col)

  local spaces = before:match('%s+$')

  if spaces and #spaces > 1 then
    -- Multiple whitespace chars before cursor: delete only the whitespace
    for _ = 1, #spaces do
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('<BS>', true, false, true), 'n', false
      )
    end
  else
    -- No whitespace, or exactly one space: delete the previous word (like Ctrl+W)
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes('<C-W>', true, false, true), 'n', false
    )
  end
end

vim.keymap.set('i', '<M-BS>', SmartBackspace, { desc = "Smart delete: whitespace or word" }) 

-- Completion menu navigation: 
-- Tab/S-Tab cycle, Enter confirms (<C-y>), else default behavior.
-- Lua ternary: cond and if-true or if-false
-- i.e. bind Tab to <C-n> if completion popup visible, otherwise send <Tab>
vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() ~= 0 and '<C-n>' or '<Tab>'
end, { expr = true })

vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn.pumvisible() ~= 0 and '<C-p>' or '<S-Tab>'
end, { expr = true })

vim.keymap.set('i', '<CR>', function()
  return vim.fn.pumvisible() ~= 0 and '<C-y>' or '<CR>'
end, { expr = true, replace_keycodes = true })


-- =============================================================================
-- FUNCTIONS
-- =============================================================================

-- Wipe all registers
vim.api.nvim_create_user_command('WipeReg', function()
  for i = 34, 122 do
    pcall(vim.fn.setreg, vim.fn.nr2char(i), {})
  end
end, {})


