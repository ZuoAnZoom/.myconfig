local nvlsp = require "nvchad.configs.lspconfig"

-- NvChad's current defaults use Neovim's native vim.lsp.config API.
nvlsp.defaults()

local servers = { "lua_ls", "html", "cssls", "pylsp", "clangd", "buf_ls" }

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

-- Buf handles Protocol Buffer files; do not let clangd attach to them.
vim.lsp.config("clangd", {
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
})

-- Current Buf CLI exposes its language server as `buf lsp serve`. The
-- modules/buf.yaml file identifies this project's Proto import root.
vim.lsp.config("buf_ls", {
  cmd = { "buf", "lsp", "serve", "--log-format=text" },
  filetypes = { "proto", "buf-config" },
  root_markers = { "buf.yaml", "buf.work.yaml", ".git" },
})

vim.lsp.enable(servers)
