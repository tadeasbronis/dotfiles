return {
    "polarmutex/git-worktree.nvim",
    version = "^2",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"},
    config = function()
        local Hooks = require("git-worktree.hooks")
        Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
            vim.notify("Switched worktree: " .. prev_path .. " → " .. path)
            Hooks.builtins.update_current_buffer_on_switch(path, prev_path)
        end)

        require("telescope").load_extension("git_worktree")

        vim.keymap.set("n", "<leader>gw", function()
            require("telescope").extensions.git_worktree.git_worktree({
                attach_mappings = function(prompt_bufnr, map)
                    -- <M-d> is intercepted by AeroSpace; use 'd' in normal mode instead
                    map("n", "d", function()
                        local selection = require("telescope.actions.state").get_selected_entry()
                        require("telescope.actions").close(prompt_bufnr)
                        if selection then
                            require("git-worktree").delete_worktree(selection.path)
                        end
                    end)
                    return true
                end
            })
        end, {})
        vim.keymap.set("n", "<leader>gW", function()
            -- Find hub dir: .git-common-dir points to .bare/, strip it to get hub
            local common_dir = vim.fn.system("git rev-parse --git-common-dir"):gsub("\n", "")
            local hub = common_dir:gsub("/%.bare$", ""):gsub("/.git$", "")

            require("telescope.builtin").git_branches({
                attach_mappings = function(_, _)
                    local actions = require("telescope.actions")
                    local action_state = require("telescope.actions.state")

                    actions.select_default:replace(function(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        local branch = selection and selection.value or action_state.get_current_line()
                        actions.close(prompt_bufnr)
                        if not branch or branch == "" then
                            return
                        end
                        local path = hub .. "/" .. branch
                        require("git-worktree").create_worktree(path, branch, branch)
                    end)
                    return true
                end
            })
        end, {})
    end
}
