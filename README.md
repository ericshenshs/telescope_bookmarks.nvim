# telescope_bookmarks.nvim

## What is `telescope_bookmarks.nvim`?

`telescope_bookmarks.nvim` is a telescope picker extension (`bookmarks`) that
helps manage the `vim-bookmarks` bookmark files.

With this extension, we can  
a) load  
b) save  
c) delete  
d) edit  
e) rename  
f) create  
a `bm`(`vim-bookmarks`) file by pressing  
a) `l`, `<CR>`  
b) `s`  
c) `d`  
d) `o`  
e) `r`  
f) `c`  
.

<!-- START doctoc -->
<!-- END doctoc -->

## Install

Simply  
a) add `{ "ericshenshs/telescope_bookmarks.nvim" }` to dependencies of Telescope  
b) `telescope.load_extension('bookmarks')` during setup of Telescope  

For example,
```lua
local telescope_config = {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  cmd = "Telescope",
  dependencies = {
    -- ...
    { "ericshenshs/telescope_bookmarks.nvim" }
    -- ...
  },
  opts = function()
    local telescope = require("telescope")
    -- ...
    telescope.load_extension('bookmarks')
    -- ...
  end
```

## Usage

Simply  
a) Run `:Telescope bookmarks cwd=` with a `cwd` path that contains the bookmark files 
  (For e.g, the path that we use for `:BookmarkSave` and `:BookmarkLoad`).
b) Map `:Telescope bookmarks cwd=` to a key (for e.g., `<leader><leader>mt` and `<leader><leader>mT`) by
```lua
vim.api.nvim_set_keymap(
  'n',
  base.customized_command_prefix .. 'mt',
  ':Telescope bookmarks cwd=' ..
  base.nvim_plugin_config.vim_bookmarks.path ..
  "<CR><Esc>",
  {})
vim.api.nvim_set_keymap(
  'n',
  base.customized_command_prefix .. 'mT',
  ':Telescope bookmarks cwd=' ..
  vim.fn.getcwd() .. "/bm/" ..
  "<CR><Esc>",
  {})
```
.

## Help

A) press `?` in normal mode of Telescope, we can see the keymaps here.

## (Additional)(Future Work) Sessions

The picker `sessions` is similar to `bookmarks` but using `mks` and `source` to Save and Load sessions.

Both the pickers `bookmarks` and `sessions` are duplicates of `find_files` but with more normal mode keymaps `sdol` here.
