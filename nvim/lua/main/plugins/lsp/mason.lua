return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    mason_lspconfig.setup({
      ensure_installed = {
        "clangd",
        "lua_ls",
        "omnisharp",
        "markdown_oxide",
        "cssls",
        "html",
        "jsonls",
        "tsserver",
        "intelephense",
        "pyright",
        "sqlls",
        "jdtls",
      },
    })
    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "isort",
        "black",
        "clang-format",
        "pylint",
        "eslint_d",
        "stylelint",
        "selene",
        -- "clangtidy", -- Embedded in clangd LSP already
        "google-java-format",
      },
    })
  end,
}
