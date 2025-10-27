return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "astro-language-server",
        "codelldb",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "hadolint",
        "json-lsp",
        "lua-language-server",
        "markdown-toc",
        "markdownlint-cli2",
        "marksman",
        "prettier",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "taplo",
        "vtsls",
        "vue-language-server", --- Make sure to run :MasonInstall vue-language-server@2.2.12, because of course the vue guys had to introduce another break change
        "wgsl-analyzer",
        "yaml-language-server",
      },
    },
  },
}
