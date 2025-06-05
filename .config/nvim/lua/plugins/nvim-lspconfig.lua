return {
  {
    "neovim/nvim-lspconfig",
    opts = function(opts)
      -- local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- keys[#keys + 1] = { "C-k", false } -- Disable

      opts.inlay_hints = { enabled = false }
    end,
  },
}
