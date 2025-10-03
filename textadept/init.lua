io.ensure_final_newline = true
textadept.editing.strip_trailing_space = true
textadept.session.save_on_quit = false
textadept.editing.auto_pairs["'"] = nil

keys['ctrl+R'] = function ()
    reset()
end

view.zoom = -1

textadept.menu.menubar['File'].title = 'File'
textadept.menu.menubar['Edit'].title = 'Edit'
textadept.menu.menubar['Tools'].title = 'Tools'
textadept.menu.menubar['Buffer'].title = 'Buffer'

local default_caret_period = view.caret_period
local dance_mode = 'command'
local function update_dance()
    if dance_mode == 'command' then
        view.caret_style = view.CARETSTYLE_BLOCK
        view.caret_period = 0
    else
        view.caret_style = view.CARETSTYLE_LINE
        view.caret_period = default_caret_period
    end
end
update_dance()

local function next_char_of(c)
    buffer.target_start = buffer.position_after(buffer.current_pos)
    buffer.target_end = buffer.length
    buffer.search_flags = buffer.FIND_MATCHCASE
    local pos = buffer:search_in_target(c)
    return pos
end

local function collapse_selections()
    for i=1,buffer.selections do
        buffer.selection_n_anchor[i] = buffer.selection_n_caret[i]
    end
end

local function eat_one_key(callback)
    local function handler(key_seq)
        if utf8.len(key_seq) == 1 then
            callback(key_seq)
        end
        events.disconnect(events.KEYPRESS, handler)
        return true
    end
    events.connect(events.KEYPRESS, handler, 1)
end

local function extend_to_search(str, search_name, found_f)
    local main = buffer.main_selection
    for i=buffer.selections,1,-1 do
        buffer.main_selection = i
        buffer:search_anchor()
        local anchor = buffer.selection_n_anchor[i]
        local found_pos = buffer[search_name](buffer.FIND_MATCHCASE, str)
        if found_pos == -1 then
            buffer:drop_selection_n(i)
        else
            buffer.selection_n_anchor[i], buffer.selection_n_caret[i] = anchor, found_f(found_pos)
        end
    end
end

local function noop(x) return x end

keys['esc'] = function ()
    dance_mode = 'command'
    update_dance()
end
keys['ctrl+s'] = function ()
    dance_mode = 'command'
    buffer.save()
    update_dance()
end
keys['i'] = function ()
    if dance_mode ~= 'command' then return false end
    for i=1,buffer.selections do
        buffer.selection_n_caret[i] = buffer.selection_n_start[i]
        buffer.selection_n_anchor[i] = buffer.selection_n_caret[i]
    end
    dance_mode = 'insert'
    update_dance()
end
keys['a'] = function ()
    if dance_mode ~= 'command' then return false end
    for i=1,buffer.selections do
        buffer.selection_n_caret[i] = buffer.selection_n_end[i]
        buffer.selection_n_anchor[i] = buffer.selection_n_caret[i]
    end
    dance_mode = 'insert'
    update_dance()
end
keys['I'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:vc_home()
    dance_mode = 'insert'
    update_dance()
end
keys['A'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:line_end()
    dance_mode = 'insert'
    update_dance()
end
keys[';'] = function ()
    if dance_mode ~= 'command' then return false end
    collapse_selections()
end
keys[','] = function ()
    if dance_mode ~= 'command' then return false end
    local m = buffer.main_selection
    local main_a, main_c = buffer.selection_n_anchor[m], buffer.selection_n_caret[m]
    buffer:set_empty_selection(main_c)
    buffer.selection_n_anchor[1] = main_a
end
keys['d'] = function ()
    if dance_mode ~= 'command' then return false end
    -- this only does 1-char delete if all selections are empty
    buffer:clear()
end
keys['c'] = function ()
    if dance_mode ~= 'command' then return false end
    -- this only does 1-char delete if all selections are empty
    buffer:clear()
    dance_mode = 'insert'
    update_dance()
end
keys['x'] = function ()
    if dance_mode ~= 'command' then return false end
    textadept.editing.select_line()
    --for i=1,buffer.selections do
    --    buffer.selection_n_end[i] = buffer:position_after(buffer.selection_n_end[i])
    --end
end
keys['F'] = function ()
    if dance_mode ~= 'command' then return false end
    eat_one_key(function (key)
        extend_to_search(key, 'search_next', function (p) return buffer:position_after(p) end)
    end)
end
keys['T'] = function ()
    if dance_mode ~= 'command' then return false end
    eat_one_key(function (key)
        extend_to_search(key, 'search_next', noop)
    end)
end
keys['f'] = function ()
    if dance_mode ~= 'command' then return false end
    eat_one_key(function (key)
        collapse_selections()
        extend_to_search(key, 'search_next', function (p) return buffer:position_after(p) end)
    end)
end
keys['t'] = function ()
    if dance_mode ~= 'command' then return false end
    eat_one_key(function (key)
        collapse_selections()
        extend_to_search(key, 'search_next', noop)
    end)
end
keys['alt+F'] = function ()
    if dance_mode ~= 'command' then return false end
    eat_one_key(function (key)
        extend_to_search(key, 'search_prev', noop)
    end)
end
keys['alt+T'] = function ()
    if dance_mode ~= 'command' then return false end
    eat_one_key(function (key)
        extend_to_search(key, 'search_prev', function (p) return buffer:position_after(p) end)
    end)
end
keys['alt+f'] = function ()
    if dance_mode ~= 'command' then return false end
    eat_one_key(function (key)
        collapse_selections()
        extend_to_search(key, 'search_prev', noop)
    end)
end
keys['alt+t'] = function ()
    if dance_mode ~= 'command' then return false end
    eat_one_key(function (key)
        collapse_selections()
        extend_to_search(key, 'search_prev', function (p) return buffer:position_after(p) end)
    end)
end
keys['w'] = function ()
    if dance_mode ~= 'command' then return false end
    collapse_selections()
    buffer:word_right_extend()
end
keys['e'] = function ()
    if dance_mode ~= 'command' then return false end
    collapse_selections()
    buffer:word_right_end_extend()
end
keys['b'] = function ()
    if dance_mode ~= 'command' then return false end
    collapse_selections()
    buffer:word_left_extend()
end
keys['W'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:word_right_extend()
end
keys['E'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:word_right_end_extend()
end
keys['B'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:word_left_extend()
end
keys['h'] = function ()
    if dance_mode ~= 'command' then return false end
    collapse_selections()
    buffer:char_left()
end
keys['l'] = function ()
    if dance_mode ~= 'command' then return false end
    collapse_selections()
    buffer:char_right()
end
keys['H'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:char_left_extend()
end
keys['L'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:char_right_extend()
end
keys['j'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:line_down()
end
keys['k'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:line_up()
end
keys['J'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:line_down_extend()
end
keys['K'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:line_up_extend()
end
keys['o'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:line_end()
    buffer:new_line()
    dance_mode = 'insert'
    update_dance()
end
keys['O'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:begin_undo_action()
    buffer:vc_home()
    buffer:new_line()
    buffer:line_up()
    buffer:end_undo_action()
    dance_mode = 'insert'
    update_dance()
end
keys['u'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:undo()
end
keys['U'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:redo()
end
