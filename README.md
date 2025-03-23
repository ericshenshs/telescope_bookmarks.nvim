# telescope_bookmarks.nvim

## What is `telescope_bookmarks.nvim`?

`telescope_bookmarks.nvim` is a telescope picker extension (`bookmarks`) that
helps manage the `vim-bookmarks` bookmark files.

With this extension, we can  
a) load  
b) save  
c) delete  
d) edit  
a `bm`(`vim-bookmarks`) file by pressing  
a) `l`, `<CR>`  
b) `s`  
c) `d`  
d) `o`  
.

<!-- START doctoc -->
<!-- END doctoc -->

## Install

Simply
a) add `{ "ericshenshs/telescope_bookmarks.nvim" }` to dependencies of Telescope
b) `telescope.load_extension('bookmarks')` during setup of Telescope
c) pass a `cwd` path (which contains the bookmark files) to Telescope by `:Telescope bookmarks cwd=`

## Help

A) press `?` in normal mode of Telescope, we can see the keymaps here.

## (Additional)(Future Work) Sessions

The picker `sessions` is similar to `bookmarks` but using `mks` and `source` to Save and Load sessions.

Both the pickers `bookmarks` and `sessions` are duplicates of `find_files` but with more normal mode keymaps `sdol` here.
