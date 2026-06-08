vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.diagnostic.config({
    virtual_text = true
})

vim.g.editorconfig = true

vim.opt.list = true
vim.opt.listchars = {
    tab = '→ ',
    trail = '·',
    space = '·',
    eol = '↲',
}

vim.opt.number = true
vim.opt.relativenumber = true
