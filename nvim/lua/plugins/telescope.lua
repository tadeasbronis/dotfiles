return {{
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {"nvim-lua/plenary.nvim", -- optional but recommended
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    }},
    config = function()
        local builtin = require("telescope.builtin")
        require("telescope").setup({
            defaults = {
                path_display = { "truncate" },
            },
            pickers = {
                find_files = {
                    cwd_only = true,
                    hidden = true,
                    file_ignore_patterns = { "%.git/" },
                },
                live_grep  = {
                    cwd_only = true,
                    additional_args = function() return { "--hidden" } end,
                    file_ignore_patterns = { "%.git/" },
                },
            },
        })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, {})
    end
}, {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
        -- This is your opts table
        require("telescope").setup({
            extensions = {
                ["ui-select"] = {require("telescope.themes").get_dropdown({
                    -- even more opts
                }) -- pseudo code / specification for writing custom displays, like the one
                -- for "codeactions"
                -- specific_opts = {
                --   [kind] = {
                --     make_indexed = function(items) -> indexed_items, width,
                --     make_displayer = function(widths) -> displayer
                --     make_display = function(displayer) -> function(e)
                --     make_ordinal = function(e) -> string
                --   },
                --   -- for example to disable the custom builtin "codeactions" display
                --      do the following
                --   codeactions = false,
                -- }
                }
            }
        })
        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("ui-select")
    end
}}
