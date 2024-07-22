---@class care.window
--- Creates a new instance of the menu window
---@field new fun(): care.window
---@field winnr? integer
--- Instance of the care config
---@field config care.config
---@field buf integer
--- Whether the window is currently opened above or below the cursor
---@field position? "above"|"below"
--- Data for the scrollbar of the window
---@field scrollbar {win: integer, buf: integer}
--- The maximum available height where the window is currently open
---@field max_height integer
--- Method to check whether the window is open or not
---@field is_open fun(self: care.window): boolean
--- Method to check whether the scrollbar window is open or not
---@field scrollbar_is_open fun(self: care.window): boolean
--- Adjust the window size to new entries. Modifies height and width while keeping position
---@field readjust fun(self: care.window, content_len: integer, width: integer, offset: integer): nil
--- Opens the window for the scrollbar
---@field open_scrollbar_win fun(self: care.window, width: integer, height: integer, offset: integer): nil
--- Closes the window and the scrollbar window and resets fields
---@field close fun(self: care.window): nil
--- Sets the scroll of the window
---@field set_scroll fun(self: care.window, index: integer, direction: integer): nil
--- Opens a new main window
---@field open_cursor_relative fun(self: care.window, width: integer, wanted_height: integer, offset: integer, config: care.config.ui.docs|care.config.ui.menu): nil
--- Draw the scrollbar for the window if needed
---@field draw_scrollbar fun(self: care.window): nil
--- Change scroll of window
---@field scroll fun(self: care.window, delta: integer)
--- Where the window was last opened
---@field opened_at {row: integer, col: integer}
--- Namespace used for setting extmarks
---@field ns integer
--- Current scroll of the window
---@field current_scroll integer
---@field get_data fun(self: care.window): care.window.data

---@class care.window.data
---@field first_visible_line integer
---@field last_visible_line integer
---@field visible_lines integer
---@field height_without_border integer
---@field width_without_border integer
---@field border any
---@field has_border boolean
---@field width_with_border integer
---@field height_with_border integer
---@field total_lines integer