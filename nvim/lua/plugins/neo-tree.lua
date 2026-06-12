return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
        require("neo-tree").setup({
            -- Show absolute + relative line numbers in the tree window so that
            -- <count>j / <count>k / <count>G work the same as in code buffers.
            -- Has to be done via event_handlers because Neo-tree windows have
            -- their own buffer type and a plain FileType autocmd doesn't catch
            -- every redraw.
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function()
                        vim.opt_local.number = true
                        vim.opt_local.relativenumber = true
                    end,
                },
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
            },
        })

        vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>", {})
        vim.keymap.set("n", "<leader>e", ":Neotree reveal<CR>", {})
    end
}
