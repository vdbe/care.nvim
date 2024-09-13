--- The config of care is used to configure the UI and care itself.
---
--- To configure care you call the setup function of the config module with the options you want
--- to override. Also see [configuration recipes](/configuration_recipes).
--- ```lua
--- require("care").setup({
---     ...
--- }
--- ```
---
--- The configuration consists of two main parts. The UI Configuration and the
--- configuration of the completion behaviors of care.
---@class care.config
--- The [UI Configuration](#Ui-Configuration) is used to configure the whole UI of care.
--- One of the main goals of this is to be as extensible as possible. This is especially important
--- for the completion entries. Read more about that under
--- [Configuration of item display](/design/#configuration-of-item-display).
---@field ui? care.config.ui
--- With this field a function for expanding snippets is defined. By default this is the
--- builtin `vim.snippet.expand()`. You can also use a plugin like luasnip for this:
---
--- ```lua
--- snippet_expansion = function(body)
---     require("luasnip").lsp_expand(body)
--- end
--- ```
---@field snippet_expansion? fun(body: string): nil
--- With the selection behavior the user can determine what happens when selecting
--- an entry. This can either be `"select"` or `"insert"`. Selecting will just
--- select the entry and do nothing else. Insert will actually insert the text of
--- the entry (this is not necessarily the whole text).
---@field selection_behavior? "select"|"insert"
--- This field controls the behavior when confirming an entry.
---@field confirm_behavior? "insert"|"replace"
--- This field is used to configure the sources for care.nvim.
--- Use a table where the fields is the source name and the value is the configuration
--- ```lua
--- sources = {
---     nvim_lsp = {
---         enabled = function()
---             ...
---         end,
---         ...
---     }
--- }
--- ```
---@field sources? table<string, care.config.source>
--- The `completion_events` table is used to set events for autocompletion. By default
--- it just contains `"TextChangedI"`. You can set it to an empty table (`{}`) to
--- disable autocompletion.
---@field completion_events? string[]
--- The keyword pattern is used to determine keywords. These are used to determine what
--- to use for filtering and what to remove if insert text is used.
--- It should essentially just describe the entries of a source.
---@field keyword_pattern? string
--- This function can be used to disable care in certain contexts. By default this
--- disables care in prompts.
---@field enabled? fun(): boolean
--- Whether items should be preselected or not. Which items are preselected is determined
--- by the source.
---@field preselect? boolean
--- How to sort the entries in the completion menu.
--- This can either be top to bottom or so the best match is always next to the cursor.
---@field sorting_direction? "top-down"|"away-from-cursor"
--- Whether debugging should be enabled or not. This will write a log to a `care.log` file
--- in the current directory.
---@field debug? boolean
--- The max entries to display in the menu. Note that this just affects
--- the entries displayed at a time. So there are still more entries on which you
--- can filter by continue typing. This limit just exists for performance reasons
--- because there are some sources which return up to multiple thousand
--- entries through which a user never will scroll.
--- The default value is 200 which will open the menu instantly in most cases so there
--- isn't much need for a lower value.
--- Values of up to about 1000 should also not cause performance issue.
---@field max_view_entries? integer

--- # Ui Configuration
--- This is used to configure the whole UI of care.
---@class care.config.ui
--- Configuration of the completion menu of care.nvim
---@field menu? care.config.ui.menu
--- This configuration allows you to configure the documentation view. It consists
--- of some basic window properties like the border and the maximum height of the
--- window. It also has a field to define the character used for the scrollbar.
---@field docs_view? care.config.ui.docs
--- This is a table which defines the different icons.
---@field type_icons? care.config.ui.type_icons
--- Configuration of ghost text.
---@field ghost_text? care.config.ui.ghost_text

--- With this field the user can control how ghost text is displayed.
---@class care.config.ui.ghost_text
--- You can use the `enabled` field to determine whether the ghost text should be
--- enabled or not.
---@field enabled? boolean
--- The `position` can either be `"inline"` or `"overlay"`. Inline
--- will add the text inline right where the cursor is. With the overlay position
--- the text will overlap with existing text after the cursor.
---@field position? "inline"|"overlay"

--- This configuration should allow you to completely adapt the completion menu to
--- your likings.
---
--- It includes some basic window properties like the border and the maximum height
--- of the window. It also has a field to define the character used for the
--- scrollbar. Set `scrollbar` to `nil` value to disable the scrollbar.
---@class care.config.ui.menu
--- Maximum height of the menu
---@field max_height? integer
--- The border of the completion menu
---@field border? string|string[]|string[][]
--- Configuration of the scrollbar
---@field scrollbar? care.config.scrollbar
--- If the menu should be displayed on top, bottom or automatically
---@field position? "auto"|"bottom"|"top"
--- Another field is `format_entry`. This is a function which recieves an entry of
--- the completion menu and determines how it's formatted. For that a table with
--- text-highlight chunks like `:h nvim_buf_set_extmarks()` is used. You can create
--- sections which are represented by tables and can have a different alignment
--- each. This is specified with another field which takes a table with the
--- alignment of each section.
---
--- For example you want to have the label of an entry in a red highlight and an
--- icon in a entry-kind specific color left aligned first and then the source of
--- the entry right aligned in blue. You could do that like this:
---
--- ```lua
--- format_entry = function(entry)
---     return {
---         -- The first section with the two chunks for the label and the icon
---         { { entry.label .. " ", "MyRedHlGroup" }, { entry.kind, "HighlightKind" .. entry.kind } }
---         -- The second section for the source
---         { { entry.source, "MyBlueHlGroup" } }
---     }
--- end,
--- alignment = { "left", "right" }
--- ```
---
--- Notice that there are multiple differences between having one table containing
--- the chunks for the label and kind and having them separately. The latter would
--- require another entry in the `alignment` table. It would also change the style
--- of the menu because the left sides of the icons would be aligned at the same
--- column and not be next to the labels. In the example there also was some spacing
--- added in between the two.
---@field format_entry? fun(entry: care.entry, data: care.format_data): { [1]: string, [2]: string }[][]
--- How the sections in the menu should be aligned
---@field alignments? ("left"|"center"|"right")[]

--- ## Source configuration
--- Configuration for the sources of care.nvim
---@class care.config.source
--- Whether the source is enabled (default true)
---@field enabled? boolean|fun():boolean
--- The maximum amount? of entries which can be displayed by this source
---@field max_entries? integer
--- The priority of this source. Is more important than matching score
---@field priority? integer
--- Filter function for entries by the source
---@field filter? fun(entry: care.entry): boolean

--- Configuration of the completion menu of care.nvim
---@class care.config.ui.docs
--- Maximum height of the documentation view
---@field max_height? integer
--- Maximum width of the documentation view
---@field max_width? integer
--- The border of the documentation view
---@field border? string|string[]|string[][]
--- Configuration of the scrollbar
---@field scrollbar? care.config.scrollbar
--- Position of docs view.
--- Auto will prefer right if there is enough space
---@field position? "auto"|"left"|"right"

--- Additional data passed to format function to allow more advanced formatting
---@class care.format_data
--- Index of the entry in the completion menu
---@field index integer
--- Whether the item is marked as deprecated by the source or not
---@field deprecated boolean
--- The name of the source from which the entry was completed
---@field source_name string
--- The display name of the source from which the entry was completed which
--- is more detailed than the normal name
---@field source_display_name string

---@class care.config.scrollbar
--- The character used for drawing the scrollbar
---@field character? string
--- Whether the scrollbar is enabled or not
---@field enabled? boolean
--- Offset of the scrollbar. 0 is at the border of the window
---@field offset? integer
