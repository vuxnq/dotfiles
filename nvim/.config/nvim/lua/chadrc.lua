-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",
  -- transparency = true,
}

M.ui = {
   statusline = {
     theme = "default", -- default/vscode/vscode_colored/minimal
     separator_style = "block",
   },

   tabufline = {
     lazyload = true,
     order = { "treeOffset", "buffers", "tabs" },
   }, 
 }

M.nvdash = {
  load_on_startup = true,

  header = {
    "            •ᴗ•            ",
    "                           ",
  },

  buttons = {
    { txt = "  find file", keys = "spc f f", cmd = "Telescope find_files" },
    { txt = "  recent files", keys = "spc f o", cmd = "Telescope oldfiles" },
    { txt = "󰈭  find word", keys = "spc f w", cmd = "Telescope live_grep" },
    { txt = "  mappings", keys = "spc c h", cmd = "NvCheatsheet" },
  },
}



return M
