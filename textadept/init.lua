io.ensure_final_newline = true
textadept.editing.strip_trailing_space = true
textadept.session.save_on_quit = false
--[[
textadept.menu.menubar['Edit'].title = 'Edit'
textadept.menu.menubar['Buffer'].title = 'Buffer'

keys['ctrl+R'] = function ()
    reset()
end

local dance_mode = 'command'
local function update_dance()
    if dance_mode == 'command' then
        view.caret_style = view.CARETSTYLE_BLOCK
    else
        view.caret_style = view.CARETSTYLE_LINE
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

-- done: esc
-- fix h l H L to move from cursor
-- fix w e b to select
-- make i move to selection start
-- unimplemented: u f t / a U F T A c y p P M-p M-P
-- counts!! W E B j k J K
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
    dance_mode = 'insert'
    update_dance()
end
keys['w'] = function ()
    if dance_mode ~= 'command' then return false end
    for i, _ in ipairs(buffer.selection_n_caret) do
        buffer.selection_n_anchor[i] = buffer.selection_n_caret[i]
    end
    buffer:word_right_extend()
end
keys['e'] = function ()
    if dance_mode ~= 'command' then return false end
    for i, _ in ipairs(buffer.selection_n_caret) do
        buffer.selection_n_anchor[i] = buffer.selection_n_caret[i]
    end
    buffer:word_right_end_extend()
end
keys['b'] = function ()
    if dance_mode ~= 'command' then return false end
    for i, _ in ipairs(buffer.selection_n_caret) do
        buffer.selection_n_anchor[i] = buffer.selection_n_caret[i]
    end
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
    buffer:char_left()
end
keys['l'] = function ()
    if dance_mode ~= 'command' then return false end
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
    buffer:begin_undo_action()
    buffer:vc_home()
    buffer:new_line()
    buffer:line_up()
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
]]
