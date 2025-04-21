local opt = vim.opt
local o = vim.o
local g = vim.g

-- Enable 24-bit color
opt.termguicolors = true

-- Disable Netrw
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Indenting
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.autoindent = true
o.smartindent = true

opt.fillchars = { eob = ' ' }
o.ignorecase = true
o.smartcase = true
o.mouse = 'a'

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false
opt.relativenumber = true

-- Disable nvim intro
opt.shortmess:append 'sI'

o.signcolumn = 'yes'
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- Interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- Go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append '<>[]hl'

-- Enable extra filetypes
vim.filetype.add {
  extension = {
    service = 'systemd',
  },
}
