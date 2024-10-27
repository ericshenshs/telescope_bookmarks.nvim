local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")

local function bookmarks_picker()
  -- Define a new picker bookmarks
  pickers.new({}, {
    prompt_title = "Vim Bookmarks",
    finder = finders.new_table({
      results = { "Option 1", "Option 2", "Option 3" },
    }),
    sorter = sorters.get_generic_fuzzy_sorter(),
    previewer = previewers.new_termopen_previewer({
      get_command = function(entry)
        return { "echo", entry.value }
      end,
    }),
  }):find()
end

return require("telescope").register_extension {
  exports = {
    bookmarks = require("bookmarks").bookmarks_picker,
  },
}
