io.ensure_final_newline = true
textadept.editing.strip_trailing_space = true
textadept.session.save_on_quit = false

--[[
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

keys['esc'] = function ()
    dance_mode = 'command'
    update_dance()
end
keys['i'] = function ()
    if dance_mode ~= 'command' then return false end
    dance_mode = nil
    update_dance()
end
keys['w'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:word_right()
end
keys['e'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:word_right_end()
end
keys['b'] = function ()
    if dance_mode ~= 'command' then return false end
    buffer:word_left()
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
keys['f'] = function ()
    if dance_mode ~= 'command' then return false end

end
