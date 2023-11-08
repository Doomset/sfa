    local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')

local gui = function ()
    local int =  new.float(cfg["���������"]["�������"]["��������"])
    local bool = new.bool(cfg["���������"]["������"])

    imgui.PushItemWidth(100)


    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - 100)

    if imgui.SliderFloat(u8'##��������', int, 0, 5, "%.2fs", 1) then
        cfg["���������"]["�������"]["��������"] = int[0]
        cfg()
    end
    imgui.PopItemWidth()


    if imgui.Checkbox(u8"������", bool) then
        cfg["���������"]["������"] = not cfg["���������"]["������"]
        cfg()
    end


    extra.color_text(imgui.ImVec4(123 / 255.0, 123 / 255.0, 111 / 255.0, 1), u8("%s, �� �������"), tostring( cfg["���������"]["�������"] ))


    extra.color_text(imgui.ImVec4(123 / 255.0, 123 / 255.0, 111 / 255.0, 1), u8"%s, �� ��� ��������", tostring( cfg["���������"]["������� �������"] ))
end

return  {"���������", "������ ����� �������� "..tostring(cfg.delay)..u8" �����������", func = gui}