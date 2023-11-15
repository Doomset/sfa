    local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')

local gui = function ()
    local int =  new.float(cfg["Автовзлом"]["Функции"]["Задержка"])
    local bool = new.bool(cfg["Автовзлом"]["Статус"])

    imgui.PushItemWidth(100)


    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - 100)

    if imgui.SliderFloat(u8'##Задержка', int, 0, 5, "%.2fs", 1) then
        cfg["Автовзлом"]["Функции"]["Задержка"] = int[0]
        cfg()
    end
    imgui.PopItemWidth()


    if imgui.Checkbox(u8"Статус", bool) then
        cfg["Автовзлом"]["Статус"] = not cfg["Автовзлом"]["Статус"]
        cfg()
    end


    extra.color_text(imgui.ImVec4(123 / 255.0, 123 / 255.0, 111 / 255.0, 1), u8("%s, ид отмычки"), tostring( cfg["Автовзлом"]["Отмычка"] ))

    extra.color_text(imgui.ImVec4(123 / 255.0, 123 / 255.0, 111 / 255.0, 1), u8"%s, ид для открытия", tostring( cfg["Автовзлом"]["Отмычка открыть"] ))
end




local blockNextTd

addEventHandler('onReceiveRpc', function(id, bs)
    if cfg["Автовзлом"]["Статус"] then

        if id == 16  then
            local soundId = raknetBitStreamReadInt32(bs)
            if soundId == 36401 and sampTextdrawIsExists(cfg["Автовзлом"]["Отмычка открыть"]) and cfg["Автовзлом"]["Статус"] then
                blockNextTd = true
                print("АВТОВЗЛОМ использование отмычки")
                sampSendClickTextdraw(cfg["Автовзлом"]["Отмычка открыть"]) --open
            end
        elseif id == 134 then
            local id = raknetBitStreamReadInt16(bs)
            raknetBitStreamIgnoreBits(bs, 16 + 8 + 32 + 32 + 32 + 32+32 + 32 + 8 + 8 + 32 + 8+ 8)
            local position_x, position_y = raknetBitStreamReadFloat(bs),raknetBitStreamReadFloat(bs)
            local ez = position_x + position_y
            if ez == 201 and cfg["Автовзлом"]["Отмычка"] ~= id then
                cfg["Автовзлом"]["Отмычка"] = id -- отмычка
                print("АВТОВЗЛОМ перезапись отмычки")
                cfg()
            elseif ez == -50 and cfg["Автовзлом"]["Отмычка открыть"] ~= id then
                cfg["Автовзлом"]["Отмычка открыть"] = id -- открыть
                print("АВТОВЗЛОМ перезапись замка")
                cfg()
            end
            
            if (position_x == 16 and position_y == -20) and cfg["Автовзлом"]["Статус"] then
                if blockNextTd then blockNextTd = nil return false end
                if cfg["Автовзлом"]["Функции"]["Задержка"] < 0.01 then sampSendClickTextdraw(cfg["Автовзлом"]["Отмычка"]) return end
                timer('seif', cfg["Автовзлом"]["Функции"]["Задержка"], function ()
                    sampSendClickTextdraw(cfg["Автовзлом"]["Отмычка"])
                end)
            end
        end

    end
end)

return  {"Автовзлом", "Сейчас стоит задержка ", func = gui}