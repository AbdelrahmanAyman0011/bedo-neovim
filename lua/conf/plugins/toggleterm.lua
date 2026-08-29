return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-t>]],
      direction = "horizontal",
      size = 15,
    })

    local terminal_height
    vim.keymap.set("n", "<leader>tf", function()
      local win = vim.api.nvim_get_current_win()

      if vim.bo.buftype ~= "terminal" then
        vim.cmd("ToggleTerm direction=horizontal")
        win = vim.api.nvim_get_current_win()
      end

      if vim.bo[vim.api.nvim_win_get_buf(win)].buftype ~= "terminal" then
        return
      end

      if terminal_height then
        vim.api.nvim_win_set_height(win, terminal_height)
        terminal_height = nil
        return
      end

      terminal_height = vim.api.nvim_win_get_height(win)
      vim.api.nvim_win_set_height(win, vim.o.lines - 2)
    end, { desc = "Toggle terminal fullscreen", silent = true })

    -- split screen shortcuts
    vim.keymap.set("n", "<C-\\>", ":ToggleTerm direction=horizontal<CR>")  -- Ctrl + \
    vim.keymap.set("n", "<C-]>", ":ToggleTerm direction=vertical<CR>")    -- Ctrl + ] 

    -- Resize the horizontal terminal panel while it is focused.
    local function resize_terminal(amount)
      return "<C-\\><C-n>:resize " .. (amount > 0 and "+" or "") .. amount .. "<CR>i"
    end

    vim.keymap.set("t", "<C-Up>", resize_terminal(5), { silent = true })
    vim.keymap.set("t", "<C-Down>", resize_terminal(-5), { silent = true })

    -- Scroll terminal output without sending commands to the shell.
    local function terminal_scroll(key)
      return "<C-\\><C-n>" .. key .. "i"
    end

    vim.keymap.set("t", "<C-u>", terminal_scroll("<C-u>"), { silent = true })
    vim.keymap.set("t", "<C-d>", terminal_scroll("<C-d>"), { silent = true })
    vim.keymap.set("t", "<PageUp>", terminal_scroll("<C-b>"), { silent = true })
    vim.keymap.set("t", "<PageDown>", terminal_scroll("<C-f>"), { silent = true })
    vim.keymap.set("t", "<ScrollWheelUp>", terminal_scroll("<C-y>"), { silent = true })
    vim.keymap.set("t", "<ScrollWheelDown>", terminal_scroll("<C-e>"), { silent = true })
  end,
}
