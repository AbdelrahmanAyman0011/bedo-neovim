return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto", -- Will auto-detect and use carbonfox theme
        icons_enabled = true,
      },
    })
  end,
}
