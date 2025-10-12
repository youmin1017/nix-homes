---@type LazySpec
return {
  "folke/sidekick.nvim",
  keys = {
    { "<M-l>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
    {
      "<M-u>",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle",
      mode = { "n", "t", "i", "x" },
    },
  },
}
