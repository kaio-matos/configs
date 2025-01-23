-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.keymap.set('i', '<C-b>', '<ESC>^i', { desc = 'move beginning of line' })
vim.keymap.set('i', '<C-e>', '<End>', { desc = 'move end of line' })
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'move left' }) -- conflicts with some keybindings from nvim-cmp (but i prefer this so its commented)
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'move right' }) -- conflicts with some keybindings from nvim-cmp (but i prefer this so its commented)
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'move down' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'move up' })

vim.keymap.set('n', '<leader>b', '<cmd>enew<CR>', { desc = 'buffer new' })

vim.keymap.set('n', '<leader>x', '<cmd>:enew<bar>bd#<CR>', { desc = 'Buffer Close' })

vim.keymap.set('t', '<C-x>', '<C-\\><C-N>', { desc = 'Terminal escape terminal mode', noremap = true })
-------------------------
---
---
---
---

--- Tab and Shift Tab
local opts = { noremap = true, silent = true }
vim.keymap.set('v', '<Tab>', '>gv', opts)
vim.keymap.set('v', '<S-Tab>', '<gv', opts)
vim.keymap.set('i', '<S-Tab>', 'C-d')

-------------------------

vim.keymap.set('n', '<leader>fm', function()
  require('conform').format { lsp_fallback = true }
end, { desc = 'general format file' })

local function nvim_tree_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts_overwrite(desc)
    return { desc = 'nvim-tree: ' .. desc }
  end

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts 'Up')
  vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
  vim.keymap.set('n', '<leader>a', '<cmd>NvimTreeFocus<cr>', opts_overwrite 'Focus Explorer')
  vim.keymap.set('n', '<leader>t', '<cmd>NvimTreeToggle<cr>', opts_overwrite 'Toggle Explorer')
end

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
        update_focused_file = {
          enable = true,
          exclude = function(buffer)
            if string.find(buffer.file, 'node_modules') then
              return true
            end
            return false
          end,
          -- update_cwd = true,
        },
        view = {
          width = {
            max = 50,
          },
        },
        git = {
          enable = true,
          ignore = false,
          timeout = 500,
        },
        on_attach = nvim_tree_on_attach,
      }
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        'css',
        'javascript',
        html = {
          mode = 'foreground',
        },
      }
    end,
  },
  {
    'mg979/vim-visual-multi',
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    'nvim-pack/nvim-spectre',
    config = function()
      vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
        desc = 'Toggle Spectre',
      })
      vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
        desc = 'Search current word',
      })
      vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
        desc = 'Search current word',
      })
      vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
        desc = 'Search on current file',
      })
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- -- Also override individual filetype configs, these take priority.
        -- -- Empty by default, useful if one of the "opts" global settings
        -- -- doesn't work well in a specific filetype
        -- per_filetype = {
        --   ['html'] = {
        --     enable_close = false,
        --   },
        -- },
      }
    end,
  },
  {
    'sindrets/diffview.nvim',
    config = function()
      vim.keymap.set('n', '<leader><leader>v', function()
        if next(require('diffview.lib').views) == nil then
          vim.cmd 'DiffviewOpen'
        else
          vim.cmd 'DiffviewClose'
        end
      end, { desc = 'diffview: View Git Diff' })
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },
}
