return {
    "mfussenegger/nvim-lint",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            terraform = {"tflint"}
        }

        vim.api.nvim_create_autocmd({"BufWritePost", "BufReadPost", "InsertLeave"}, {
            callback = function()
                require("lint").try_lint()
            end
        })
    end
}
