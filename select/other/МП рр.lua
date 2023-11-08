local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')

local gui = function ()
    if not imgui then imgui = require('mimgui') end

    if not core["������"]["�� ��"] then
        core["������"]["�� ��"] = {
            ["�����"] = new.char[28](u8"Nikolay"),
            ["���������"] = new.char[28](u8"3"),
            ["���"] = new.int(0),
            ["��������"] = new.int(0),
        }
    end

    extra.centerText(u8"���", 30)

    local adm, mess = str(core["������"]["�� ��"]["�����"]), str(core["������"]["�� ��"]["���������"])

    



    extra.centerText(string.format(u8"%s[%s]: %s",adm , "12" ,mess), 50, extra.U32ToImVec4(bit.rshift(-1, 8)))




    extra.centerText(string.format(u8"[��] %s[%s]: %s",adm , "12" ,mess), 80, extra.U32ToImVec4(bit.rshift(-3407617, 8))) --��

    local p = imgui.GetWindowSize().x / 2 - 100 /2

    imgui.SetCursorPosX(p - imgui.CalcTextSize(u8"��� ������ ����������� ��").x / 2)

    imgui.PushItemWidth(100)
    imgui.InputText(u8"��� ������ ����������� ��## input2", core["������"]["�� ��"]["�����"], sizeof(core["������"]["�� ��"]["�����"]))

    imgui.SetCursorPosX(p - imgui.CalcTextSize(u8"��� ������ ����������� ��").x / 2)

    imgui.InputText(u8"���������## input2", core["������"]["�� ��"]["���������"], sizeof(core["������"]["�� ��"]["�����"]))

    imgui.SetCursorPosX(p - imgui.CalcTextSize(u8"�� ����, ���� ���� �������").x / 2)
    imgui.InputInt(u8"�� ����, ���� ���� �������## input3", core["������"]["�� ��"]["���"], 0, 0)
    imgui.SetCursorPosX(p - imgui.CalcTextSize(u8"�������� ����� ���������").x / 2)
    imgui.InputInt(u8"�������� ����� ���������## input3", core["������"]["�� ��"]["��������"], 0, 0)
    imgui.PopItemWidth()

end


return  {'�� �� ', 'ICON_COINS',  true, "����� ������ ������-������ ���������� ���� �� �� ������� �������, � ��� ����� �� ��������", gui}
