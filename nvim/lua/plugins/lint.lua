return {
    "mfussenegger/nvim-lint",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            terraform = {"tflint"}
        }

        -- Helper: returns true if the current buffer's file lives inside a
        -- terraform project that has been initialized (i.e. .terraform/ exists
        -- somewhere up the tree). tflint without .terraform/ is slow and
        -- usually errors out anyway.
        local function terraform_initialized(bufnr)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            if fname == "" then return false end
            local found = vim.fs.find(".terraform", {
                upward = true,
                path = vim.fs.dirname(fname),
                type = "directory",
            })
            return #found > 0
        end

        vim.api.nvim_create_autocmd({"BufWritePost", "BufReadPost", "InsertLeave"}, {
            callback = function(args)
                if vim.bo[args.buf].filetype == "terraform"
                    and not terraform_initialized(args.buf) then
                    return
                end
                require("lint").try_lint()
            end
        })
    end
}
