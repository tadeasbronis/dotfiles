-- Show cursorline only in the active window.
--
-- The cursorline option is enabled globally in config/options.lua, but is
-- window-local at runtime. These autocmds toggle it on WinEnter/WinLeave so
-- that only the focused split shows the highlight, making it obvious which
-- window has focus.

local cursorline_group = vim.api.nvim_create_augroup("ActiveWindowCursorline", { clear = true })

-- Filetypes where cursorline is unwanted (own highlighting or visually noisy).
local excluded_ft = {
  ["neo-tree"] = true,
  alpha = true,
  TelescopePrompt = true,
}

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
  group = cursorline_group,
  callback = function()
    if not excluded_ft[vim.bo.filetype] then
      vim.wo.cursorline = true
    end
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline_group,
  callback = function()
    vim.wo.cursorline = false
  end,
})
