local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local find_files = require('telescope.builtin').find_files

local function delete_file(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local file_path = entry.path or entry.filename
  local confirm = vim.fn.input("Delete " .. file_path .. "? (y/n): ")
  if confirm:lower() == "y" then
    vim.fn.delete(file_path)
    -- actions.close(prompt_bufnr)
    print("Deleted " .. file_path)
  else
    print("Canceled deletion")
  end
end

local function load_sessions(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local file_path = entry.path or entry.filename
  local confirm = vim.fn.input("Load sessions in " .. file_path .. "? (y/n): ")
  if confirm:lower() == "y" then
    actions.close(prompt_bufnr)
    print("Loaded " .. file_path)
    vim.cmd('source ' .. file_path)
  else
    print("Canceled load")
  end
end

local function rename_sessions(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local file_path = entry.path or entry.filename
  local directory = vim.fn.fnamemodify(file_path, ":h")
  local confirm = vim.fn.input("Rename sessions " .. file_path .. "? (y/n): ")
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
  else
    print("Canceled rename")
  end
end

local function save_sessions(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local file_path = entry.path or entry.filename
  local confirm = vim.fn.input("Save sessions to " .. file_path .. "? (y/n): ")
  if confirm:lower() == "y" then
    vim.cmd('mksession! ' .. file_path)
    print("Saved to " .. file_path)
    rename_sessions(prompt_bufnr)
    actions.close(prompt_bufnr)
  else
    print("Canceled save")
  end
end

local function edit_sessions(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local file_path = entry.path or entry.filename
  actions.close(prompt_bufnr)
  vim.cmd('edit ' .. file_path)
end

local function sessions_picker(opts)
  -- Inherits the find_files picker.
  -- with parameter overrides.
  opts = vim.tbl_deep_extend("force", {
    prompt_title = "sessions",
    attach_mappings = function(prompt_bufnr, map)
      -- Custom keymap: Open URL in browser
      map("n", "d", delete_file)
      map("n", "s", save_sessions)
      map("n", "l", load_sessions)
      map("n", "r", rename_sessions)
      map("n", "o", edit_sessions)
      -- load when select
      actions.select_default:replace(function()
        -- load the sessionswithout asking
        local entry = action_state.get_selected_entry()
        local file_path = entry.path or entry.filename
        actions.close(prompt_bufnr)
        print("Loaded " .. file_path)
        vim.cmd('source ' .. file_path)
        -- refresh the quickfix
      end)
      return true
    end
  }, opts or {})

  -- Inherits the find_files picker.
  return find_files(opts)
end

return require("telescope").register_extension {
  exports = {
    sessions = sessions_picker,
  },
}
