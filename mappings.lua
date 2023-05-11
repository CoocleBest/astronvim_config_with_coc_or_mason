-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local utils = require "astronvim.utils"
local is_available = utils.is_available
local my_utils = require "user.utils.utils"

local a = 1
local maps = { i = {}, n = {}, v = {}, t = {}, c = {}, o = {}, x = {} }

local system = vim.loop.os_uname().sysname

if vim.g.neovide then
  if system == "Darwin" then
    vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key
    -- Save
    maps.n["<D-s>"] = ":w<CR>"
    -- Paste normal mode
    maps.n["<D-v>"] = '"+P'
    -- Copy
    maps.v["<D-c>"] = '"+y'
    -- Paste visual mode
    maps.v["<D-v>"] = '"+P'
    -- Paste command mode
    maps.c["<D-v>"] = "<C-R>+"
    -- Paste insert mode
    maps.i["<D-v>"] = '<esc>"+pli'
  elseif system == "window" then
  end
end

maps.n["<leader><leader>"] = { desc = "󰍉 User" }
-- maps.n["<leader>m"] = { desc = "󱂬 Translate" }
maps.n["s"] = "<Nop>"

maps.n["<leader>r"] = { desc = " Refactor" }
maps.v["<leader>r"] = { desc = " Refactor" }
-- refactoring
-- Remaps for the refactoring operations currently offered by the plugin
maps.v["<leader>rf"] = {
  "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
  desc = "Extract Function",
}
maps.v["<leader>rF"] = {
  "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
  desc = "Extract Function To File",
}
maps.v["<leader>rv"] = {
  "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
  desc = "Extract Variable",
}
maps.v["<leader>ri"] =
  { "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", desc = "Inline Variable" }

-- Extract block doesn't need visual mode
maps.n["<leader>rb"] = {
  "<Cmd>lua require('refactoring').refactor('Extract Block')<CR>",
  desc = "Extract Block",
}
maps.n["<leader>rB"] = {
  "<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
  desc = "Extract Block To File",
}
-- Inline variable can also pick up the identifier currently under the cursor without visual mode
maps.n["<leader>ri"] = {
  "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
  desc = "Inline Variable",
}

-- Debug
-- maps.n["<leader>ds"] = { function() require("dap").run_to_cursor() end, desc = "Run To Cursor" }
-- maps.n["<leader>dC"] =
-- { function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end, desc = "Conditional Breakpoint" }
--
-- if is_available "nvim-dap-ui" then
--   maps.n["<leader>dE"] =
-- ---@diagnostic disable-next-line: missing-parameter
--   { function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input" }
-- ---@diagnostic disable-next-line: missing-parameter
--   maps.v["<leader>dE"] = { function() require("dapui").eval() end, desc = "Evaluate Input" }
-- end
-- maps.n["<leader>ds"] = { "<cmd>lua require'dap'.run_to_cursor()<cr>", desc = "Run to Cursor" }
-- maps.n["<leader>dE"] = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", desc = "Evaluate Input" }
-- maps.n["<leader>dC"] =
--   { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", desc = "Conditional Breakpoint" }

-- tmux
maps.n["<C-h>"] = { "<cmd>lua require'tmux'.move_left()<cr>", desc = "Go to left window" }
maps.n["<C-l>"] = { "<cmd>lua require'tmux'.move_right()<cr>", desc = "Go to right window" }
maps.n["<C-j>"] = { "<cmd>lua require'tmux'.move_bottom()<cr>", desc = "Go to bottom window" }
maps.n["<C-k>"] = { "<cmd>lua require'tmux'.move_top()<cr>", desc = "Go to top window" }

maps.n["<C-Up>"] = { "<cmd>lua require'tmux'.resize_top()<cr>", desc = "Resize split up" }
maps.n["<C-Down>"] = { "<cmd>lua require'tmux'.resize_bottom()<cr>", desc = "Resize split down" }
maps.n["<C-Left>"] = { "<cmd>lua require'tmux'.resize_left()<cr>", desc = "Resize split left" }
maps.n["<C-Right>"] = { "<cmd>lua require'tmux'.resize_right()<cr>", desc = "Resize split right" }

maps.n["m"] = { desc = "Marks" }
maps.n["m,"] = { "<Plug>(Marks-setnext)<CR>", desc = "Set Next Lowercase Mark" }
maps.n["m;"] = { "<Plug>(Marks-toggle)<CR>", desc = "Toggle Mark(Set Or Cancel Mark)" }
maps.n["m]"] = { "<Plug>(Marks-next)<CR>", desc = "Move To Next Mark" }
maps.n["m["] = { "<Plug>(Marks-prev)<CR>", desc = "Move To Previous Mark" }
maps.n["m:"] = { "<Plug>(Marks-preview)", desc = "Preview Mark" }

maps.n["dm"] = { "<Plug>(Marks-delete)", desc = "Delete Marks" }
maps.n["dm-"] = { "<Plug>(Marks-deleteline)<CR>", desc = "Delete All Marks On The Current Line" }
maps.n["dm<space>"] = { "<Plug>(Marks-deletebuf)<CR>", desc = "Delete All Marks On Current Buffer" }

maps.n["H"] = { "^", desc = "Go to start without blank" }
maps.n["L"] = { "$", desc = "Go to end without blank" }

-- $跳到行尾不带空格(交换$和g_)
maps.n["$"] = { "g_", desc = "Go to end without blank" }
maps.n["g_"] = { "$", desc = "Go to end" }
maps.v["$"] = { "g_", desc = "Go to end without blank" }
maps.v["g_"] = { "$", desc = "Go to end" }
maps.n["0"] = { "^", desc = "Go to start without blank" }
maps.n["^"] = { "0", desc = "Go to start" }
maps.v["0"] = { "^", desc = "Go to start without blank" }
maps.v["^"] = { "0", desc = "Go to start" }

-- auto save开关
maps.n["<leader>um"] = { ":ASToggle<CR>", desc = "Toggle AutoSave" }

-- visual multi
vim.g.VM_maps = {
  ["Find Under"] = "<C-n>",
  ["Find Subword Under"] = "<C-n>",
  ["Add Cursor Up"] = "<C-S-k>",
  ["Add Cursor Down"] = "<C-S-j>",
  ["Select All"] = "<C-S-n>",
  ["Skip Region"] = "<C-x>",
}

-- telescope plugin mappings
maps.v["<leader>f"] = { desc = "󰍉 Find" }
maps.n["<leader>fp"] = { function() require("telescope").extensions.projects.projects {} end, desc = "Find projects" }
maps.n["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" }
maps.n["<leader>fM"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
maps.n["<leader>fm"] = { "<cmd>Telescope media_files<cr>", desc = "Find media files" }
maps.v["<leader>fr"] =
  { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", desc = "Find code refactors" }
-- maps.n["<leader>fR"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }

-- 上下滚动10行
maps.n["<C-u>"] = { "5k", desc = "Move down 5 lines" }
maps.n["<C-d>"] = { "5j", desc = "Move up 5 lines" }
maps.v["<C-u>"] = { "5k", desc = "Move down 5 lines" }
maps.v["<C-d>"] = { "5j", desc = "Move up 5 lines" }

-- 开启魔术搜索,即可以通过正则来搜索
-- maps.n["/"] = { "/\\v", desc = "Magic search" }
-- maps.v["/"] = { "/\\v", desc = "Magic search" }

-- visual模式下缩进代码, 缩进后仍然可以继续选中区域
maps.v["<"] = { "<gv", desc = "Indent to the left" }
maps.v[">"] = { ">gv", desc = "Indent to the right" }
maps.v["<Tab>"] = false
maps.v["<S-Tab>"] = false

-- 上下移动选中文本
-- maps.v["J"] = { ":move '>+1<CR>gv-gv", desc = "Move selected one line down" }
-- maps.v["K"] = { ":move '<-2<CR>gv-gv", desc = "Move selected one line up" }

-- 在visual mode 里粘贴不要复制
maps.n["x"] = { '"_x', desc = "Cut without copy" }

-- 关闭搜索高亮
maps.n["<leader>nh"] = { ":nohlsearch<CR>", desc = "Close search highlight" }

-- 分屏快捷键
maps.n["<leader>bw"] = { "<C-w>c", desc = "Close current screen" }
maps.n["<leader>bo"] = { "<C-w>o", desc = "Close other screen" }
-- 多个窗口之间跳转
maps.n["<leader>b="] = { "<C-w>=", desc = "Make all window equal" }

-- better search
maps.n["n"] = { my_utils.better_search "n", desc = "Next search" }
maps.n["N"] = { my_utils.better_search "N", desc = "Previous search" }

-- lsp restart
maps.n["<leader>lm"] = { ":LspRestart<CR>", desc = "Lsp restart" }

-- Comment
if is_available "Comment.nvim" then
  maps.n["<C-/>"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Comment line",
  }
  maps.v["<C-/>"] =
    { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Toggle comment line" }
end
maps.n["<leader>/"] = false
maps.v["<leader>/"] = false

-- leap
maps.n["<leader>s"] = {
  function()
    local current_window = vim.fn.win_getid()
    require("leap").leap { target_windows = { current_window } }
  end,
  desc = "Bidirectional search",
}
maps.n["<leader><leader>s"] = {
  function()
    local focusable_windows_on_tabpage = vim.tbl_filter(
      function(win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )
    require("leap").leap { target_windows = focusable_windows_on_tabpage }
  end,
  desc = "Search in all windows",
}

-- substitute, 交换和替换插件, 寄存器中的值，将会替换到s位置, s{motion}
maps.n["s"] = { require("substitute").operator, desc = "Replace with {motion}" }
maps.n["ss"] = { require("substitute").line, desc = "Replace with line" }
maps.n["S"] = { require("substitute").eol, desc = "Replace until eol" }
maps.v["p"] = { require("substitute").visual, desc = "Replace in visual" }
-- exchange
maps.n["sx"] = { require("substitute.exchange").operator, desc = "Exchange with {motion}" }
maps.n["sxx"] = { require("substitute.exchange").line, desc = "Exchange with line" }
maps.n["sxc"] = { require("substitute.exchange").cancel, desc = "Exchange exchange" }
maps.v["X"] = { require("substitute.exchange").visual, desc = "Exchange in visual" }

maps.n["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" }
maps.n["<leader>bD"] = {
  function()
    require("astronvim.utils.status").heirline.buffer_picker(
      function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
    )
  end,
  desc = "Pick to close",
}

-- trouble
maps.n["<leader>x"] = { desc = "裂Trouble" }
maps.n["<leader>xx"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" }
maps.n["<leader>xX"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" }
maps.n["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" }
maps.n["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" }
maps.n["<leader>xT"] = { "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" }

-- better increment/decrement
-- maps.x["+"] = { "g<C-a>", desc = "Increment number" }
-- maps.x["-"] = { "g<C-x>", desc = "Descrement number" }

-- buffer switching
maps.n["<leader>bt"] = {
  function()
    if #vim.t.bufs > 1 then
      require("telescope.builtin").buffers { sort_mru = true, ignore_current_buffer = true }
    else
      utils.notify "No other buffers open"
    end
  end,
  desc = "Switch Buffers In Telescope",
}

-- zen mode
maps.n["<leader>z"] = { "<cmd>ZenMode<cr>", desc = "Zen Mode" }

-- TsInformation
maps.n["<leader>lT"] = { "<cmd>TSInstallInfo<cr>", desc = "Tree sitter Information" }

return maps
