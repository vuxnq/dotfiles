require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- save
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- menu
map({ "n", "v" }, "<RightMouse>", function()
  -- require('menu.utils').delete_old_menus()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true, border = true })
end, {})
