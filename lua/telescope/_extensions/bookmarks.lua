local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local find_files = require('telescope.builtin').find_files

local function bookmarks_picker(opts)
  opts = vim.tbl_deep_extend("force", {
    prompt_title = "Bookmarks",
  }, opts or {})

  -- Define a new picker bookmarks
  return find_files(opts):find()
end

return require("telescope").register_extension {
  exports = {
    bookmarks = bookmarks_picker,
  },
}
