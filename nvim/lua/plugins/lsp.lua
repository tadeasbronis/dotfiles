return {{
    "mason-org/mason.nvim",
    config = function()
        require("mason").setup()
    end
}, {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {"mason-org/mason.nvim"},
    config = function()
        require("mason-tool-installer").setup({
            ensure_installed = { -- LSP servers
            "lua-language-server", "taplo", -- Formatters
            "stylua", "prettier", "shfmt", -- Linters
            "salt-lint"}
        })
    end
}, {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {{
        "mason-org/mason.nvim",
        opts = {}
    }, {"neovim/nvim-lspconfig"}},
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {"lua_ls", "taplo"}
        })

        vim.lsp.config("lua_ls", {})
        vim.lsp.enable("lua_ls")
        vim.lsp.config("taplo", {})
        vim.lsp.enable("taplo")

        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
        vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})
    end
}, {
    "hrsh7th/cmp-nvim-lsp",
    dependencies = {"hrsh7th/nvim-cmp"}
}, {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {null_ls.builtins.formatting.stylua, null_ls.builtins.formatting.prettier.with({
                filetypes = {"javascript", "typescript", "json", "yaml", "markdown", "salt"},
                extra_args = function(params)
                    if params.ft == "salt" then
                        return {"--parser", "yaml"}
                    end
                    return {}
                end,
            }), null_ls.builtins.formatting.shfmt, null_ls.builtins.diagnostics.saltlint.with({
                filetypes = {"salt", "yaml"}
            })}
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end
}}

