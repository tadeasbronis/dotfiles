vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.diagnostic.config({
  virtual_text = true,
})

vim.g.editorconfig = true

vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  eol = "↲",
}

vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight the current line. The autocmds in config/autocmds.lua restrict
-- the highlight to the active window only, so it doubles as an "active
-- window" indicator across splits.
-- cursorlineopt: "both" highlights both the line background and the line
-- number. Other options: "line" | "number" | "screenline".
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"

-- LSP logging for debugging
-- Log file location: ~/.local/state/nvim/lsp.log
-- Levels: vim.log.levels.TRACE | .DEBUG | .INFO | .WARN | .ERROR | .OFF
-- Use INFO or DEBUG temporarily when troubleshooting LSP issues.
vim.lsp.log.set_level(vim.log.levels.WARN)
