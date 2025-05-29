return {
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
              disabled = { "unresolved-proc-macro", "proc-macro-disabled" },
              enableExperimental = true,
            },
          },
        },
      },
    },
  },
}
