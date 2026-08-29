return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      -- apply default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- remove the <C-t> mapping so toggleterm can use it
      vim.keymap.del("n", "<C-t>", { buffer = bufnr })
    end

    require("nvim-tree").setup {
      on_attach = my_on_attach,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },
    }

    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>")
  end,
}
