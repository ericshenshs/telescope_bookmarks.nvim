local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local find_files = require('telescope.builtin').find_files

local function delete_file(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local file_path = entry.path or entry.filename
  local confirm = vim.fn.input("Delete " .. file_path .. "? (y/n): ")
  if confirm:lower() == "y" then
    vim.fn.delete(file_path)
    actions.close(prompt_bufnr)
    print("Deleted " .. file_path)
  else
    print("Canceled deletion")
  end
end

local function bookmarks_picker(opts)
  -- Inherits the find_files picker.
  -- with parameter overrides.
  opts = vim.tbl_deep_extend("force", {
    prompt_title = "Bookmarks",
    attach_mappings = function(prompt_bufnr, map)
      -- Custom keymap: Open URL in browser
      map("n", "d", delete_file)
      map("n", "p", delete_file)
      return true
    end
  }, opts or {})

  -- Inherits the find_files picker.
  return find_files(opts)
end

return require("telescope").register_extension {
  exports = {
    bookmarks = bookmarks_picker,
  },
}
