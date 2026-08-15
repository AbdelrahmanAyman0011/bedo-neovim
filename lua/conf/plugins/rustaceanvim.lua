return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<leader>cr", function()
            vim.cmd.RustLsp("runnables")
          end, { desc = "Rust Runnables", buffer = bufnr })
          vim.keymap.set("n", "<leader>ca", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Rust Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>ce", function()
            vim.cmd.RustLsp("explainError")
          end, { desc = "Rust Explain Error", buffer = bufnr })
          vim.keymap.set("n", "<leader>em", function()
            vim.cmd.RustLsp("expandMacro")
          end, { desc = "Rust Expand Macro", buffer = bufnr })
          
          -- Optional: If you want to use rustaceanvim's hover instead of standard LSP hover
          vim.keymap.set("n", "K", function()
            vim.cmd.RustLsp { "hover", "actions" }
          end, { desc = "Rust Hover Actions", buffer = bufnr })
        end,
      },
    }
  end,
}
