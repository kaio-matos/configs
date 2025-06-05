-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "move end of line" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "move left" }) -- conflicts with some keybindings from nvim-cmp (but i prefer this so its commented)
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "move right" }) -- conflicts with some keybindings from nvim-cmp (but i prefer this so its commented)
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "move up", remap = true, silent = true })

vim.keymap.set("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode", noremap = true })

--- Tab and Shift Tab
local opts = { noremap = true, silent = true }
vim.keymap.set("v", "<Tab>", ">gv", opts)
vim.keymap.set("v", "<S-Tab>", "<gv", opts)
-- vim.keymap.set("i", "<S-Tab>", "<gv", opts)

-- Clear Terminal (along with history) with Ctrl+l
local term_clear = function()
  vim.fn.feedkeys("^L", "n")
  local sb = vim.bo.scrollback
  vim.bo.scrollback = 1
  vim.bo.scrollback = sb
end

vim.keymap.set("t", "<C-l>", term_clear)
