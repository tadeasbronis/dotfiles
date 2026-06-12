-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", {})
vim.keymap.set("n", "<C-j>", "<C-w>j", {})
vim.keymap.set("n", "<C-k>", "<C-w>k", {})
vim.keymap.set("n", "<C-l>", "<C-w>l", {})

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {})

-- LSP diagnostics
vim.keymap.set("n", "<leader>li", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    print("No LSP clients attached to this buffer")
    return
  end
  for _, client in ipairs(clients) do
    print(string.format("- %s (id=%d, root=%s)", client.name, client.id, client.root_dir or "n/a"))
  end
end, { desc = "LSP: list clients in current buffer" })

vim.keymap.set("n", "<leader>ll", function()
  vim.cmd("tabnew " .. vim.lsp.get_log_path())
end, { desc = "LSP: open log file" })

vim.keymap.set("n", "<leader>lh", "<cmd>checkhealth vim.lsp<CR>", { desc = "LSP: checkhealth" })
