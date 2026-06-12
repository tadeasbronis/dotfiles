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

-- LSP logging for debugging
-- Log file location: ~/.local/state/nvim/lsp.log
-- Levels: vim.log.levels.TRACE | .DEBUG | .INFO | .WARN | .ERROR | .OFF
-- Use INFO or DEBUG temporarily when troubleshooting LSP issues.
vim.lsp.log.set_level(vim.log.levels.WARN)
