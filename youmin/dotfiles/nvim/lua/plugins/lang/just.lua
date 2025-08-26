vim.lsp.enable("just")

---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "just" } },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "just-lsp" } },
  },
}
