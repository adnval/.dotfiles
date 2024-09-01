-- Set variable for vim.opt
local opt = vim.opt

-- Set the file explorer to tree format
vim.cmd("let g:netrw_liststyle = 3")

-- Configure line numbers
opt.relativenumber = true
opt.number = true

-- Configure tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Configure line wrapping
opt.wrap = false

-- Configure search settings
opt.ignorecase = true
opt.smartcase = true

-- Configure cursor line highlighting
opt.cursorline = true

-- Configure termguicolors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Configure backspace
opt.backspace = "indent,eol,start"

-- Configure clipboard
opt.clipboard:append("unnamedplus")

-- Configure split views
opt.splitright = true
opt.splitbelow = true

-- Configure swap files
opt.swapfile = false
