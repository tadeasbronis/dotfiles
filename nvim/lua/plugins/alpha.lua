return {{
    "MaximilianLloyd/ascii.nvim",
    dependencies = {"MunifTanjim/nui.nvim"}
}, {
    "goolord/alpha-nvim",
    dependencies = {"nvim-tree/nvim-web-devicons", "MaximilianLloyd/ascii.nvim"},
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = require("ascii").get_random("gaming", "pacman")
        dashboard.section.header.opts.hl = "AlphaPacman"
        local colors = require("catppuccin.palettes").get_palette()
        vim.api.nvim_set_hl(0, "AlphaPacman", {
            fg = colors.sky
        })

        dashboard.section.buttons.val = {dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                                         dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
                                         dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
                                         dashboard.button("g", "  Live grep", ":Telescope live_grep <CR>"),
                                         dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
                                         dashboard.button("q", "  Quit", ":qa <CR>")}

        alpha.setup(dashboard.config)
    end
}}
