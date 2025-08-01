-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = ""
vim.opt.relativenumber = false

vim.filetype.add({
  pattern = {
    [".env.*"] = "sh",
  },
})
