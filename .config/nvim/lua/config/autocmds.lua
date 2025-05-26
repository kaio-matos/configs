-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.rs",
  callback = function()
    local cwd = vim.fn.getcwd()
    if vim.fn.filereadable(cwd .. "/Dioxus.toml") == 1 then
      local command = "dx fmt"
      vim.cmd("silent ! " .. command)
      --vim.notify("dx fmt")
    end
  end,
})
