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
            "lua-language-server", "taplo", "bash-language-server", -- Formatters
            "stylua", "prettier", "beautysh", -- Linters
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
            ensure_installed = {"lua_ls", "taplo", "bashls"}
        })

        vim.lsp.config("lua_ls", {})
        vim.lsp.enable("lua_ls")
        vim.lsp.config("taplo", {})
        vim.lsp.enable("taplo")
        vim.lsp.config("bashls", {
            filetypes = {"sh", "zsh", "bash"}
        })
        vim.lsp.enable("bashls")

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
        local h = require("null-ls.helpers")
        local methods = require("null-ls.methods")

        local beautysh = h.make_builtin({
            name = "beautysh",
            method = methods.internal.FORMATTING,
            filetypes = {"sh", "zsh", "bash"},
            generator_opts = {
                command = "beautysh",
                args = {"-"},
                to_stdin = true,
            },
            factory = h.formatter_factory,
        })

        null_ls.setup({
            sources = {null_ls.builtins.formatting.stylua, null_ls.builtins.formatting.prettier.with({
                filetypes = {"javascript", "typescript", "json", "yaml", "markdown", "salt"},
                extra_args = function(params)
                    if params.ft == "salt" then
                        return {"--parser", "yaml"}
                    end
                    return {}
                end,
            }), beautysh, null_ls.builtins.diagnostics.saltlint.with({
                filetypes = {"salt", "yaml"}
            })}
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end
}}

