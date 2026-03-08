vim.cmd.colorscheme("moondark")

vim.opt.laststatus = 3

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.fillchars = { eob = " " }
vim.opt.listchars = "tab:> ,trail:•,nbsp:+"
vim.opt.list = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.hlsearch = false
vim.opt.wrap = false

vim.opt.pumheight = 10

vim.opt.shortmess:append({c = true})
vim.opt.showmode = false

vim.opt.title = true
vim.opt.titlestring = "%(%M%)%t - Nvim"

vim.opt.confirm = true

vim.opt.formatoptions:remove({ "c", "r", "o" })

vim.g.c_syntax_for_h = 1

----------------
-- STATUSLINE --
----------------

function statusline_get_mode()
    local current_mode = vim.fn.mode()
    local modes = {
        ['n']   = "NOR",
        ['i']   = "INS",
        ['v']   = "VIS",
        ['V']   = "VLN",
        ["\22"] = "BLK",
        ['c']   = "CMD",
        ['R']   = "RPL",
        ['!']   = "SHL",
        ['t']   = "TER",
    }
    return modes[current_mode] or "---"
end

function statusline_get_icon()
    local filetype = vim.opt.filetype:get()
    local map = {
        asm = "",
        c = "",
        cpp = "",
        css = "",
        go = "",
        haskell = "",
        help = "󰋗",
        html = "",
        java = "",
        javascript = "󰌞",
        javascriptreact = "󰌞",
        lua = "󰢱",
        markdown = "",
        make = "",
        netrw = "󰙅",
        oil = "󰙅",
        python = "",
        rust = "󱘗",
        sh = "",
        svelte = "",
        typescript = "󰛦",
        typescriptreact = "󰛦",
        vim = "",
        vue = "",
        zsh = "",
    }
    local result = map[filetype] or ""
    return result
end

local stats = {
    "%#StatusLineMode#",
    "%{%v:lua.statusline_get_mode()%}%#StatusLine#",
    "%<%f %{%v:lua.statusline_get_icon()%} %m",
    "%=",
    -- "%{%v:lua.require'statusline'.lsp()%}",
    "%l:%c",
    "%y ",
}

vim.opt.statusline = table.concat(stats, " ")

-------------
-- KEYMAPS --
-------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Select a word and type <C-r> in visual mode to replace every instace
-- of it with a provided input, aka automated substitute command
vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', { noremap = true })

-- Exit terminal mode with C-x
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { noremap = true })

--------------
-- AUTOCMDS --
--------------

-- Disable treesitter for a few filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "man", "lua" },
    callback = function() vim.treesitter.stop() end,
})

-- Delete trailling whitespace on every save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup(
        "WhitespaceCleaner", { clear = true }
    ),
    pattern = "*",
    command = ":%s/\\s\\+$//e"
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup(
        "YankHighlight", { clear = true }
    ),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Remeber cursor last position
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup(
        "RememberLastPosition", { clear = true }
    ),
    pattern = "*",
    callback = function()
        local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
        local buf_line_count = vim.api.nvim_buf_line_count(0)
        if row >= 1 and row <= buf_line_count then
            vim.api.nvim_win_set_cursor(0, { row, column })
        end
    end,
})

-------------
-- PLUGINS --
-------------

local plugins = {
    {
        name = "neogit",
        path = vim.fn.stdpath("data") .. "/site/pack/neogit/start/neogit",
        url = "https://github.com/NeogitOrg/neogit.git",
        dependencies = {
            {
                name = "plenary.nvim",
                path = vim.fn.stdpath("data") .. "/site/pack/plenary.nvim/start/plenary.nvim",
                url = "https://github.com/nvim-lua/plenary.nvim.git",
            },
        },
    },
    {
        name = "oil.nvim",
        path = vim.fn.stdpath("data") .. "/site/pack/oil.nvim/start/oil.nvim",
        url = "https://github.com/stevearc/oil.nvim.git",
    },
    {
        name = "jai.vim",
        path = vim.fn.stdpath("data") .. "/site/pack/jai.vim/start/jai.vim",
        url = "https://github.com/jansedivy/jai.vim.git",
    },
}

local function install_plugin(plug)
    vim.notify("Installing '" .. plug.name .. "' plugin...", vim.log.levels.WARN)
    vim.cmd("redraw")

    local out = vim.fn.system({"git", "clone", "--depth=1", plug.url, plug.path})

    if vim.v.shell_error ~= 0 then
        vim.notify("Failed to clone '" .. plug.name .. "' plugin\nErrorMsg: " .. out , vim.log.levels.ERROR)
        os.exit(1)
    end

    vim.opt.rtp:prepend(plug.path)
    if vim.uv.fs_stat(plug.path .. "/doc") then
        vim.cmd("helptags " .. plug.path .. "/doc")
    end

    vim.notify("Plugin '" .. plug.name .. "' is installed!", vim.log.levels.INFO)
    vim.cmd("redraw")
end

for k, plug in pairs(plugins) do
    if not vim.uv.fs_stat(plug.path) then
        install_plugin(plug)

        if plug.dependencies then
            for k, dep in pairs(plug.dependencies) do
                if not vim.uv.fs_stat(dep.path) then
                    install_plugin(dep)
                end
            end
        end
    end
end

local function plug_require(plug_name)
    local ok, result = pcall(require, plug_name)
    if not ok then
        vim.notify("Failed to load '" .. plug_name .. "' plugin" , vim.log.levels.WARN)
        return nil
    end
    return result
end

local oil = plug_require("oil")
if oil then
    oil.setup({
        default_file_explorer = true,
        float        = { border = "rounded" },
        confirmation = { border = "rounded" },
        progress     = { border = "rounded" },
        ssh          = { border = "rounded" },
        keymaps_help = { border = "rounded" },
    })

    vim.keymap.set("n", "<leader>o", ":Oil<CR>", { noremap = true, silent = true })
end

local neogit = plug_require("neogit")
if neogit then
    vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Open Neogit UI" })
end
