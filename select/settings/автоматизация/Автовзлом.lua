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

return  {"Автовзлом", "Сейчас стоит задержка "..tostring(cfg.delay)..u8" миллисекунд", func = gui}