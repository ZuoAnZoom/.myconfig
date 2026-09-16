require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- macOS Option+i is a dead-key combination in the English input source, so
-- provide input-method-independent ways to toggle NvChad's floating terminal.
local function toggle_float_terminal()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end

map({ "n", "t" }, "<F12>", toggle_float_terminal, { desc = "Terminal toggle floating" })
map("n", "<leader>i", toggle_float_terminal, { desc = "Terminal toggle floating" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
