local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')

local gui = function ()
    local gol = ds[685]

    --local int = new.int(gol.id)
    local bool = new.bool(gol.on)

    extra.color_text(imgui.ImVec4(123 / 255.0, 123 / 255.0, 111 / 255.0, 1), u8("%s, ид текстдрава"), tostring( cfg["gol"].Ид ))		
end

return {"Автоеда",  "Если на текстраве голод будет 25 похавает с инвентаря еду, если нет её отключится", func = gui}