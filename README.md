# telescope_bookmarks.nvim

## What is `telescope_bookmarks.nvim`?

`telescope_bookmarks.nvim` is a telescope picker extension (`bookmarks`) that
helps manage the `vim-bookmarks` bookmark files.

With this extension, we can  
a) load  
b) save (force save)  
c) delete  
d) edit  
e) rename  
f) create  
a `bm`(`vim-bookmarks`) file by pressing  
a) `l`, `<CR>`  
b) `s` (`S`)  
c) `d`  
d) `o`  
e) `r`  
f) `c`  
.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Install](#install)
- [Usage](#usage)
- [Help](#help)
- [Tips](#tips)
- [(Additional)(Future Work) Sessions](#additionalfuture-work-sessions)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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

## Tips

a) rename bookmarks with format `20250323_<name>_revision` to sort the bookmarks and doc the commit to check in.

## (Additional)(Future Work) Sessions

The picker `sessions` is similar to `bookmarks` but using `mks` and `source` to Save and Load sessions.

Both the pickers `bookmarks` and `sessions` are duplicates of `find_files` but with more normal mode keymaps `sdol` here.
