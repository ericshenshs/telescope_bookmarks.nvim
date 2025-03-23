local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local find_files = require('telescope.builtin').find_files

local function delete_file(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local picker = action_state.get_current_picker(prompt_bufnr)
  local file_path = entry.path or entry.filename
  local confirm = vim.fn.input("Delete " .. file_path .. "? (y/n): ")
  if confirm:lower() == "y" then
    vim.fn.delete(file_path)
    print("Deleted " .. file_path)
    picker:refresh(picker.finder, { reset_prompt = true })
  else
    print("Canceled deletion")
  end
end

local function load_bookmarks(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local file_path = entry.path or entry.filename
  local confirm = vim.fn.input("Load Bookmarks in " .. file_path .. "? (y/n): ")
  if confirm:lower() == "y" then
    actions.close(prompt_bufnr)
    print("Loaded " .. file_path)
    vim.cmd('BookmarkLoad ' .. file_path)
    -- refresh the quickfix
    vim.cmd('BookmarkShowAll')
    vim.cmd('BookmarkShowAll')
  else
    print("Canceled load")
  end
end

local function create_bookmarks(prompt_bufnr)
  local confirm = vim.fn.input("Create bookmarks? (y/n): ")
  local picker = action_state.get_current_picker(prompt_bufnr)
  local directory = picker.cwd
  if confirm:lower() == "y" then
    local new_filename = vim.fn.input("New name is? : ")
    local file_path = directory .. "/" .. new_filename
    vim.cmd('BookmarkSave ' .. file_path)
    print("Saved to " .. file_path)
    picker:refresh(picker.finder, { reset_prompt = true })
  else
    print("Canceled create")
  end
end

local function rename_bookmarks(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local file_path = entry.path or entry.filename
  local picker = action_state.get_current_picker(prompt_bufnr)
  local directory = vim.fn.fnamemodify(file_path, ":h")
  local confirm = vim.fn.input("Rename bookmarks " .. file_path .. "? (y/n): ")
  if confirm:lower() == "y" then
    local new_filename = vim.fn.input("New name is? : ")
    local new_path = directory .. "/" .. new_filename
    vim.uv.fs_rename(file_path, new_path, function(err)
      if err then
        print("Error renaming file:", err)
      else
        print("File renamed successfully to " .. new_path)
      end
    end)
    picker:refresh(picker.finder, { reset_prompt = true })
  else
    print("Canceled rename")
  end
end

local function save_bookmarks(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local picker = action_state.get_current_picker(prompt_bufnr)
  local file_path = entry.path or entry.filename
  local confirm = vim.fn.input("Save Bookmarks to " .. file_path .. "? (y/n): ")
  if confirm:lower() == "y" then
    vim.cmd('BookmarkSave ' .. file_path)
    print("Saved to " .. file_path)
    rename_bookmarks(prompt_bufnr)
    picker:refresh(picker.finder, { reset_prompt = true })
  else
    print("Canceled save")
  end
end

local function save_bookmarks_force(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local picker = action_state.get_current_picker(prompt_bufnr)
  local file_path = entry.path or entry.filename
  vim.cmd('BookmarkSave ' .. file_path)
  print("Saved to " .. file_path)
  picker:refresh(picker.finder, { reset_prompt = true })
end

local function edit_bookmarks(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local file_path = entry.path or entry.filename
  actions.close(prompt_bufnr)
  vim.cmd('edit ' .. file_path)
end

local function bookmarks_picker(opts)
  -- Inherits the find_files picker.
  -- with parameter overrides.
  opts = vim.tbl_deep_extend("force", {
    prompt_title = "Bookmarks",
    attach_mappings = function(prompt_bufnr, map)
      -- Custom keymap: Open URL in browser
      map("n", "d", delete_file)
      map("n", "s", save_bookmarks)
      map("n", "S", save_bookmarks_force)
      map("n", "l", load_bookmarks)
      map("n", "o", edit_bookmarks)
      map("n", "r", rename_bookmarks)
      map("n", "c", create_bookmarks)
      -- load when select
      actions.select_default:replace(function()
        -- load the bookmark without asking
        local entry = action_state.get_selected_entry()
        local file_path = entry.path or entry.filename
        actions.close(prompt_bufnr)
        print("Loaded " .. file_path)
        vim.cmd('BookmarkLoad ' .. file_path)
        -- refresh the quickfix
        vim.cmd('BookmarkShowAll')
        vim.cmd('BookmarkShowAll')
      end)
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
