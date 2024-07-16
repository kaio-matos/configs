local function nvim_tree_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  -- local function opts(desc)
  --   return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  -- end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts 'Up')
  -- vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
  vim.keymap.set('n', '<leader>a', '<cmd>NvimTreeFocus<cr>', { desc = 'Focus Explorer' })
  vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle Explorer' })
end

-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        on_attach = nvim_tree_on_attach,
      }
    end,
  },
}
