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




local blockNextTd

addEventHandler('onReceiveRpc', function(id, bs)
    if cfg["���������"]["������"] then

        if id == 16  then
            local soundId = raknetBitStreamReadInt32(bs)
            if soundId == 36401 and sampTextdrawIsExists(cfg["���������"]["������� �������"]) and cfg["���������"]["������"] then
                blockNextTd = true
                print("��������� ������������� �������")
                sampSendClickTextdraw(cfg["���������"]["������� �������"]) --open
            end
        elseif id == 134 then
            local id = raknetBitStreamReadInt16(bs)
            raknetBitStreamIgnoreBits(bs, 16 + 8 + 32 + 32 + 32 + 32+32 + 32 + 8 + 8 + 32 + 8+ 8)
            local position_x, position_y = raknetBitStreamReadFloat(bs),raknetBitStreamReadFloat(bs)
            local ez = position_x + position_y
            if ez == 201 and cfg["���������"]["�������"] ~= id then
                cfg["���������"]["�������"] = id -- �������
                print("��������� ���������� �������")
                cfg()
            elseif ez == -50 and cfg["���������"]["������� �������"] ~= id then
                cfg["���������"]["������� �������"] = id -- �������
                print("��������� ���������� �����")
                cfg()
            end
            
            if (position_x == 16 and position_y == -20) and cfg["���������"]["������"] then
                if blockNextTd then blockNextTd = nil return false end
                if cfg["���������"]["�������"]["��������"] < 0.01 then sampSendClickTextdraw(cfg["���������"]["�������"]) return end
                timer('seif', cfg["���������"]["�������"]["��������"], function ()
                    sampSendClickTextdraw(cfg["���������"]["�������"])
                end)
            end
        end

    end
end)

return  {"���������", "������ ����� �������� ", func = gui}