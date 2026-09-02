return {
  "tinted-theming/tinted-vim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.base16_colorspace = 256
    vim.cmd([[colorscheme base16-default-dark]])
  end,
}
