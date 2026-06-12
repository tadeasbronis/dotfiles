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
            "lua-language-server", "taplo", "bash-language-server", "terraform-ls", -- Formatters
            "stylua", "prettier", "beautysh", -- Linters
            "salt-lint", "tflint"}
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
            ensure_installed = {"lua_ls", "taplo", "bashls", "terraformls"},
            -- Disable automatic enabling of all installed LSP servers.
            -- We enable them manually below so we can apply conditional
            -- root_dir logic (e.g. terraformls only attaches to projects with
            -- an initialized .terraform/ directory).
            automatic_enable = false,
        })

        vim.lsp.config("lua_ls", {})
        vim.lsp.enable("lua_ls")
        vim.lsp.config("taplo", {})
        vim.lsp.enable("taplo")
        vim.lsp.config("bashls", {
            filetypes = {"sh", "zsh", "bash"}
        })
        vim.lsp.enable("bashls")

        -- terraformls: only attach when the project has been initialized
        -- (i.e. a .terraform/ directory exists somewhere up the tree).
        -- Without .terraform/, terraform-ls indexes every local module from
        -- scratch and blocks the main thread, freezing nvim on large
        -- monorepos. Run `terraform init` (or `tofu init`) in the project to
        -- enable the LSP there.
        local function terraform_root(bufnr)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            if fname == "" then return nil end
            local found = vim.fs.find(".terraform", {
                upward = true,
                path = vim.fs.dirname(fname),
                type = "directory",
            })
            if #found == 0 then return nil end
            return vim.fs.dirname(found[1])
        end

        vim.lsp.config("terraformls", {
            filetypes = {"terraform", "terraform-vars"},
            root_dir = function(bufnr, on_dir)
                local root = terraform_root(bufnr)
                if root then on_dir(root) end
                -- If no .terraform/ found, on_dir is never called, so
                -- nvim won't start the LSP for this buffer.
            end,
        })
        vim.lsp.enable("terraformls")

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
            }), null_ls.builtins.formatting.opentofu_fmt}
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function()
                vim.lsp.buf.format({timeout_ms = 3000})
            end
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end
}}

