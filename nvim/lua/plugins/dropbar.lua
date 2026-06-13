-- Bekaboo/dropbar.nvim — IDE-style breadcrumb in the winbar showing the
-- file path plus the LSP/treesitter symbol path (e.g. the resource block
-- the cursor is currently inside in a .tf file).
--
-- Requires Neovim 0.10+.
--
-- Keymaps:
--   <leader>;  pick/navigate the dropbar with the keyboard
return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    -- nvim-web-devicons is already pulled in by other plugins (neo-tree,
    -- lualine) so we don't list it here to avoid duplicate specs.
  },
  keys = {
    {
      "<leader>;",
      function()
        require("dropbar.api").pick()
      end,
      desc = "Dropbar: pick component",
    },
  },
  config = function()
    require("dropbar").setup({})
  end,
}
