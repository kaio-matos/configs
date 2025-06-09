return {

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      image = { enabled = true },
      picker = {
        enabled = true,
        formatters = {
          file = {
            truncate = 100, -- truncate the file path to (roughly) this length
          },
        },
      },
    },
  },
}
