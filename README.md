# telescope_bookmarks.nvim

<!-- START doctoc -->
<!-- END doctoc -->

## What is `telescope_bookmarks.nvim`?

We create a picker extension for telescope called `bookmarks`` to manage the vim-bookmarks files for quick switch (load) (`l` or `<CR>`), save (`s`), delete (`d`) and edit (`o`).

## Installation
Simply
a) add `{ "ericshenshs/telescope_bookmarks.nvim" }` to dependencies of Telescope
b) `telescope.load_extension('bookmarks')` during setup of Telescope
c) pass a cwd of bookmark files to Telescope by `:Telescope bookmarks cwd=`

Note that
A) this plugin is to help `{MattesGroeger/vim-bookmarks}` using Telescope.
B) press `?` in normal mode of Telescope, we can see shortcuts here.

## Sessions

The picker `sessions` is similar to `bookmarks` but using `mks` and `source` to Save and Load sessions.

Both the pickers `bookmarks` and `sessions` are duplicates of `find_files` but with more normal mode keymaps `sdol` here.
