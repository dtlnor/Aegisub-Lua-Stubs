-- Aegisub Lua API stubs
-- This file provides type annotations and function signatures for the Aegisub Lua API.

-- This will be fine as these are just stubs.
--- @diagnostic disable: duplicate-set-field


aegisub.lua_automation_version = 4.0

-- Registration

-- Script information globals
--- @type string|nil Name of the script. This should be short.
script_name = nil

--- @type string|nil Description of the purpose of the script. Shouldn't be too long either.
script_description = nil

--- @type string|number|nil Version number/name of the script. This is freeform; no specific meaning is assigned to this.
script_version = nil

--- @type string|nil Author credits for the script.
script_author = nil

aegisub = {}

--- Register a macro feature that appears in the Automation menu.
--- @param name string The name displayed on the Automation menu. Use forward slashes (/) to create submenus.
--- @param description string The description displayed on the status bar when hovering over the menu item. Keep at most 60 characters.
--- @param processing_function fun(subtitles: Subtitles, selected_lines: table, active_line: number): table|nil, number|nil The function called when the user selects the menu item. Returns new selected_lines and active_line.
--- @param validation_function? fun(subtitles: Subtitles, selected_lines: table, active_line: number): boolean, string|nil Optional function to determine if the macro should be available. Returns true/false and optional description override.
--- @param is_active_function? fun(subtitles: Subtitles, selected_lines: table, active_line: number): boolean, string|nil Optional function to determine if the macro should show a check mark. Uses same API as validation function.
function aegisub.register_macro(name, description, processing_function, validation_function, is_active_function)
end

--- Register an export filter feature that appears in the Export dialogue.
--- @param name string The name displayed in the export filters list. Should be rather short.
--- @param description string The description displayed when the user highlights the export filter in the Export dialogue.
--- @param priority number Determines initial ordering of export filter application. Higher priority = applied earlier. Transform Framerate=1000, Clean Script Info=0, Fix Styles=-5000.
--- @param processing_function fun(subtitles: Subtitles, settings: table) The function called when the user initiates export operation.
--- @param configuration_panel_provider? fun(subtitles: Subtitles, old_settings: table): table Optional function that provides a configuration panel for the export filter.
function aegisub.register_filter(name, description, priority, processing_function, configuration_panel_provider)
end

-- Subtitles Class

--- Base line table structure - all line types inherit these fields
--- @class LineBase
--- @field class string The name of the class of line this is ("info", "style", "dialogue", "unknown")
--- @field raw string The raw text of the line, from first to last character on the physical line
--- @field section string|nil Which section of the file the line belongs to. If the line is placed before the first section heading, this field is nil

--- Info class line - key/value pair in the Script Info section
--- @class InfoLine : LineBase
--- @field class "info"
--- @field key string The part of the line before the first colon, with leading and trailing spaces removed
--- @field value string Everything after the first colon on the line, also with leading and trailing spaces removed

--- Style class line - regular style definition
--- @class StyleLine : LineBase
--- @field class "style"
--- @field section "[V4+ Styles]"
--- @field name string Name of the style
--- @field fontname string Name of the font face used by the style
--- @field fontsize number Font size for the style
--- @field color1 string Primary colour used by the style
--- @field color2 string Secondary colour used by the style
--- @field color3 string Outline colour used by the style
--- @field color4 string Shadow colour used by the style
--- @field bold boolean|number true/false for bold/non-bold, or number for font weight
--- @field italic boolean Whether an italic/oblique version of the font face is used
--- @field underline boolean Whether to apply underline decoration to the text
--- @field strikeout boolean Whether to apply strikeout decoration to the text
--- @field scale_x number Scaling in X direction, 100 is neutral
--- @field scale_y number Scaling in Y direction, 100 is neutral
--- @field spacing number Additional spacing in pixels between individual characters
--- @field angle number Z axis rotation for the text
--- @field borderstyle number 1 for regular outlined text, 3 for opaque box behind subtitles
--- @field outline number Width of the extended outline around the text
--- @field shadow number Distance to the shadow behind the text
--- @field align number Numpad-style alignment for the text on screen
--- @field margin_l number Left margin for the style
--- @field margin_r number Right margin for the style
--- @field margin_t number Top margin for the style
--- @field margin_b number Bottom margin for the style
--- @field margin_v number Convenience alias for margin_t (added by karaskel)
--- @field encoding number Windows font encoding ID for the style
--- @field relative_to number Currently unsupported
--- @field vertical boolean Unsupported, tentative AS5 feature

--- Dialogue class line - dialogue or comment line
--- @class DialogueLine : LineBase
--- @field class "dialogue"
--- @field section "[Events]"
--- @field comment boolean true if the line is a Comment line rather than Dialogue
--- @field layer number Layer of the line
--- @field start_time number Start time of the line in milliseconds
--- @field end_time number End time of the line in milliseconds
--- @field style string Name of the style used for the line
--- @field actor string Actor field for the line
--- @field margin_l number Left margin override, 0 means use margin from style
--- @field margin_r number Right margin override, 0 means use margin from style
--- @field margin_t number Top margin override, 0 means use margin from style
--- @field margin_b number Bottom margin override, 0 means use margin from style
--- @field effect string Effect field of the line
--- @field userdata string Unused field
--- @field text string Dialogue text
--- @field text_stripped string Line text with all override tags and vector drawings removed (added by karaskel)
--- @field duration number Duration of the line in milliseconds (added by karaskel)
--- @field styleref StyleLine Reference to the Style table representing this line's selected style (added by karaskel)
--- @field furistyle StyleLine|false Reference to furigana layout style, or false if none (added by karaskel)
--- @field width number Width of stripped line text in pixels (added by karaskel)
--- @field height number Height of stripped line text in pixels (added by karaskel)
--- @field descent number Descent of stripped line text in pixels (added by karaskel)
--- @field extlead number External leading of stripped line text in pixels (added by karaskel)
--- @field margin_v number Convenience alias for margin_t (added by karaskel)
--- @field eff_margin_l number Effective left margin (added by karaskel)
--- @field eff_margin_r number Effective right margin (added by karaskel)
--- @field eff_margin_t number Effective top margin (added by karaskel)
--- @field eff_margin_b number Effective bottom margin (added by karaskel)
--- @field eff_margin_v number Effective vertical margin (added by karaskel)
--- @field halign "left"|"center"|"right" Horizontal alignment derived from style (added by karaskel)
--- @field valign "top"|"middle"|"bottom" Vertical alignment derived from style (added by karaskel)
--- @field left number Left edge X coordinate for the line (added by karaskel)
--- @field center number Center X coordinate for the line (added by karaskel)
--- @field right number Right edge X coordinate for the line (added by karaskel)
--- @field top number Top edge Y coordinate for the line (added by karaskel)
--- @field middle number Middle Y coordinate for the line (added by karaskel)
--- @field vcenter number Alias for middle (added by karaskel)
--- @field bottom number Bottom edge Y coordinate for the line (added by karaskel)
--- @field x number X coordinate suitable for \pos tag (added by karaskel)
--- @field y number Y coordinate suitable for \pos tag (added by karaskel)
--- @field kara table Array of karaoke syllable tables (added by karaskel)
--- @field furi table Array of furigana syllable tables (added by karaskel)

--- Unknown class line - unknown kind of line
--- @class UnknownLine : LineBase
--- @field class "unknown"

--- Union type for all possible line types
--- @alias Line InfoLine | StyleLine | DialogueLine | UnknownLine

--- The subtitles object for manipulating subtitle files
--- @class Subtitles
--- @field n number Number of lines in the subtitle file (same as #subtitles)
local Subtitles = {}

--- Get the number of lines in the subtitle file
--- @return number count Number of lines
function Subtitles:__len()
    return 0
end

--- Read a line from the subtitle file
--- @param index number Line index (1-based)
--- @return Line line The line data table
function Subtitles:__index(index)
    return {}
end

--- Set/replace a line in the subtitle file
--- @param index number Line index (1-based), use 0 to append, negative to insert
--- @param line Line|nil Line data table to set, or nil to delete
function Subtitles:__newindex(index, line)
end

--- Append one or more lines to the end of the subtitle file
--- @param ... Line Lines to append
function Subtitles:append(...)
end

--- Insert one or more lines at the specified position
--- @param index number Position to insert before (1-based)
--- @param ... Line Lines to insert
function Subtitles:insert(index, ...)
end

--- Delete one or more lines by index
--- @param ... number Indices of lines to delete
function Subtitles:delete(...)
end

--- Delete a range of lines
--- @param first number Index of first line to delete (inclusive)
--- @param last number Index of last line to delete (inclusive)
function Subtitles:deleterange(first, last)
end

--- Create an undo point for macro operations
--- @param description string Description of the action for the undo menu
function aegisub.set_undo_point(description)
end

-- Progress reporting

--- Progress reporting functions
aegisub.progress = {}

--- Set the position of the percent-done bar in the progress window.
--- @param percent number Number from 0 to 100
function aegisub.progress.set(percent)
end

--- Set the "task" text in the progress window, which is the small text below the progress bar.
--- @param msg string A format string specifying the message
--- @param ... any Parameters to the format string
function aegisub.progress.task(msg, ...)
end

--- Set the title of the progress window, which is the large text displayed above the progress bar.
--- @param title string A format string specifying the title
--- @param ... any Parameters to the format string
function aegisub.progress.title(title, ...)
end

--- Check whether the user has clicked on the Cancel button.
--- @return boolean cancelled false if the user has not clicked Cancel, true if they have
function aegisub.progress.is_cancelled()
    return false
end

--- Debug output functions
aegisub.debug = {}

--- Send a message to the message log, optionally with a specific severity level.
--- Severity levels: 0=fatal, 1=error, 2=warning, 3=hint, 4=debug, 5=trace
--- @param level number|string severity level (0-5)
--- @param msg? string format string message
--- @param ... any Parameters to the format string
function aegisub.debug.out(level, msg, ...)
end

--- Send a message to the message log, optionally with a specific severity level.
--- Severity levels: 0=fatal, 1=error, 2=warning, 3=hint, 4=debug, 5=trace
--- @param msg? string format string message
--- @param ... any Parameters to the format string
function aegisub.debug.out(msg, ...)
end

--- Alias for aegisub.debug.out - send a message to the message log.
aegisub.log = aegisub.debug.out

--- Dialog APIs
aegisub.dialog = {}

--- Base dialog control table - all control types inherit these fields
--- @class DialogControlBase
--- @field class string The class of control ("label", "edit", "intedit", "floatedit", "textbox", "dropdown", "checkbox", "color", "coloralpha", "alpha")
--- @field x number X position in the dialog grid
--- @field y number Y position in the dialog grid
--- @field width number Width in grid units
--- @field height number Height in grid units

--- Label control - displays text to the user
--- @class DialogLabelControl : DialogControlBase
--- @field class "label"
--- @field label string The text displayed to the user

--- Text edit control - single line text input
--- @class DialogEditControl : DialogControlBase
--- @field class "edit"
--- @field name string Unique identifier for the control
--- @field text string Initial text content
--- @field hint? string Tooltip text

--- Integer edit control - integer number input
--- @class DialogIntEditControl : DialogControlBase
--- @field class "intedit"
--- @field name string Unique identifier for the control
--- @field value number Initial integer value
--- @field min? number Minimum allowed value (requires max to be set)
--- @field max? number Maximum allowed value (requires min to be set)
--- @field hint? string Tooltip text

--- Float edit control - floating point number input
--- @class DialogFloatEditControl : DialogControlBase
--- @field class "floatedit"
--- @field name string Unique identifier for the control
--- @field value number Initial float value
--- @field min? number Minimum allowed value (requires max to be set)
--- @field max? number Maximum allowed value (requires min to be set)
--- @field step? number Size of change when spin buttons are clicked
--- @field hint? string Tooltip text

--- Multi-line text box control
--- @class DialogTextBoxControl : DialogControlBase
--- @field class "textbox"
--- @field name string Unique identifier for the control
--- @field text string Initial text content (can contain newlines)
--- @field hint? string Tooltip text

--- Dropdown selection control
--- @class DialogDropdownControl : DialogControlBase
--- @field class "dropdown"
--- @field name string Unique identifier for the control
--- @field items table Array of strings for dropdown options
--- @field value string Initially selected item
--- @field hint? string Tooltip text

--- Checkbox control
--- @class DialogCheckboxControl : DialogControlBase
--- @field class "checkbox"
--- @field name string Unique identifier for the control
--- @field label string Text displayed next to checkbox
--- @field value boolean Initial checked state
--- @field hint? string Tooltip text

--- Color picker control (RGB)
--- @class DialogColorControl : DialogControlBase
--- @field class "color"
--- @field name string Unique identifier for the control
--- @field value string Initial color value in "#RRGGBB" format
--- @field hint? string Tooltip text

--- Color picker with alpha control (RGBA)
--- @class DialogColorAlphaControl : DialogControlBase
--- @field class "coloralpha"
--- @field name string Unique identifier for the control
--- @field value string Initial color value in "#RRGGBBAA" format
--- @field hint? string Tooltip text

--- Alpha channel control
--- @class DialogAlphaControl : DialogControlBase
--- @field class "alpha"
--- @field name string Unique identifier for the control
--- @field value string Initial alpha value in "#AA" format
--- @field hint? string Tooltip text

--- Union type for all dialog control types
--- @alias DialogControl DialogLabelControl | DialogEditControl | DialogIntEditControl | DialogFloatEditControl | DialogTextBoxControl | DialogDropdownControl | DialogCheckboxControl | DialogColorControl | DialogColorAlphaControl | DialogAlphaControl

--- Dialog definition - array of dialog controls
--- @alias DialogDefinition DialogControl[]

--- Dialog result table containing user input values
--- @class DialogResult
--- @field [string] string|number|boolean|nil Values keyed by control names

--- Button ID mapping for dialog buttons
--- @alias DialogButtonIds { [string]: string }

--- Display a configuration dialog to the user
--- @param dialog DialogDefinition Array of dialog control tables
--- @param buttons? string[] Optional array of button labels. If not provided, standard Ok/Cancel buttons appear
--- @param button_ids? DialogButtonIds Optional mapping of button IDs to button labels for platform-specific behavior
--- @return boolean|string button Boolean (true=Ok, false=Cancel) if standard buttons, or string with button text if custom buttons
--- @return DialogResult result_table Table containing user input values keyed by control names
function aegisub.dialog.display(dialog, buttons, button_ids)
    return false, {}
end

--- Open a file selection dialog
--- @param title string Title of the dialog
--- @param default_file string Default filename to preselect (may be empty)
--- @param default_dir string Initial directory to show (if empty, last used directory is shown)
--- @param wildcards string File filters (e.g., "All Files (*.*)|*.*|Text files (*.txt)|*.txt")
--- @param allow_multiple? boolean If true, allow selecting multiple files (returns table instead of string)
--- @param must_exist? boolean If true, only allow selecting files that exist
--- @return string|table|nil file_name nil if cancelled, string if single file, table if multiple files
function aegisub.dialog.open(title, default_file, default_dir, wildcards, allow_multiple, must_exist)
    return nil
end

--- Open a file save dialog
--- @param title string Title of the dialog
--- @param default_file string Default filename to preselect (may be empty)
--- @param default_dir string Initial directory to show (if empty, last used directory is shown)
--- @param wildcards string File filters (e.g., "All Files (*.*)|*.*|Text files (*.txt)|*.txt")
--- @param dont_prompt_for_overwrite? boolean If true, don't ask for overwrite confirmation
--- @return string|nil file_name nil if cancelled, string with selected file path otherwise
function aegisub.dialog.save(title, default_file, default_dir, wildcards, dont_prompt_for_overwrite)
    return nil
end

-- Misc. APIs

--- Immediately end execution of the current script, rolling back any changes that have been made in it.
function aegisub.cancel()
end

--- Obtain system font metrics and determine the rendered size in pixels of the given text when using the style.
--- @param style table A style table as defined by the subtitle interface. The font name, size, weight, style, spacing and encoding is used to determine the size of the text.
--- @param text string The text the extents should be determined for. This should not contain line breaks (\n or \r\n) nor should it contain formatting codes of any kind.
--- @return number width Width in pixels of text. This may be non-integer.
--- @return number height Height in pixels of the text. This may be non-integer.
--- @return number descent Length of descenders in the font. This may be non-integer.
--- @return number ext_lead External leading for the font. This may be non-integer.
function aegisub.text_extents(style, text)
    return 0, 0, 0, 0
end

--- Get the translation for a string. This is mostly only intended for scripts bundled with Aegisub.
--- @param untranslated string The string to get translation for
--- @return string translation The translated string
function aegisub.gettext(untranslated)
    return untranslated
end

--- Use loaded frame rate data to convert an absolute time given in milliseconds into a frame number.
--- @param ms number Absolute time from the beginning of the video, for which to determine the frame number.
--- @return number|nil frame Frame number corresponding to the time in ms, or nil if there is no frame rate data loaded.
function aegisub.frame_from_ms(ms)
    return nil
end

--- Use loaded frame rate data to convert a frame number of the video into an absolute time in milliseconds.
--- @param frame number Frame to obtain the beginning time of.
--- @return number|nil ms First integer millisecond time stamp to lie within the frame, or nil if there is no frame rate data loaded.
function aegisub.ms_from_frame(frame)
    return nil
end

--- Get information about the resolution and aspect-ratio of the loaded video, if any.
--- @return number|nil xres Coded width of the video in pixels, or nil if there is no video loaded.
--- @return number|nil yres Coded height of the video in pixels, or nil if there is no video loaded.
--- @return number ar Custom display aspect ratio override. Meaningless unless artype is 4.
--- @return number artype Aspect ratio type: 0=square pixels, 1=4:3, 2=16:9, 3=2.35, 4=custom (see ar parameter)
function aegisub.video_size()
    return nil, nil, 0, 0
end

--- Get a list of what video frames are keyframes.
--- @return table keyframes A sorted table where each entry is the frame number of a keyframe. If no keyframe data is loaded, the table will be empty.
function aegisub.keyframes()
    return {}
end

--- Convert a path beginning with a path specifier to an absolute path.
--- @param encoded_path string A string which may optionally begin with an Aegisub path specifier.
--- @return string path If encoded_path began with a valid path specifier, an absolute path. Any other strings are passed through untouched.
function aegisub.decode_path(encoded_path)
    return encoded_path
end

--- Get a table containing information about what files the user currently has open.
--- @return table properties A table containing project properties. The exact contents are deliberately undocumented and may change without warning.
function aegisub.project_properties()
    return {}
end

--- Getting the audio waveform selection position and duration
--- @return number start_ms Start position of the audio selection in milliseconds
--- @return number end_ms End position of the audio selection in milliseconds
function aegisub.get_audio_selection()
    return 0, 0
end


--- Setting the main frame's status bar text
--- @param text string The text to display in the status bar
function aegisub.set_status_bar_text(text)
end