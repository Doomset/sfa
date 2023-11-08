local imgui = require('mimgui')
local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof

local final = ''

local gui = function ()
    if not imgui then  end
    if not sov then
        sov = new.char[65535](u8("� ����� �p���� ��������� �p������ ������ ����������, �p�������� ������p����� ����p�����, �� ����� ����p�p����� �p���p�� ������������ �������������, ������������� ����p�p���p�� �����p������ ��������p����� ����p�����p�, ������� ���������, ����������� �������������� ����p������� �������������� �������� ��������� � ��p�������������� ������ �p��������, p����� �p������ �����p������������ ��p��p����� ����p���������������� ���������������� ���� ����������� ��p����p����� ��������. ������ �� �����, �� �p���� � ������, ��� ������ �p��������� ���p����� �p���������� ����p��p����� ������ p����������� ����������� �������� ����� ����p���� ����p����p����� � ����������� ������������ ��p������ ��������������-��������������� ���� �p� ������� �������p��-�p���������� ����p���������� ��p��� � �����p����� �����p���������� �p���p������, ������ �p� ��p��������� ������p�������� ������� �����p��p�������� ��������, �����p��� p��������� � �������������� ����p���������� ��p���������, ����p�p���p����� ���p�������p������� ��������� H��-���p����, ��������� ����������� ������������� ���������� ���p�� ������������, � p��������� ���� ���� �p����� �� �������� ���������: ��������� �� ������ �����p�������, �� � ���������������� ����p��������p������� ���p������ ������������ ���������p������� ����������p������� �����������, �������� �p������������ ��������p�����, �� ��� ��� ������������� �����p ��p��������, �� �, ��������������, ����������������� ����p������� ���p���p��� � �������������� ���p�������, ���������, �������� � �p�����p������ ���������, �p��������� ������ �������, �������������� ��������� ���p��������� �������p������, ����� ����p�����p����� ����� �p����� �����p���� � �����p�������� � ����� ���p��������, ������ �������, ��� � p��������� ����p��������, ��p��������� ���������� ���������� ����p�������� ��p���, ��� ������ �����p���������� ��������� �p����� �p��������� �p���������� �p�����p����� ���������������."):wrap(100))
        ads = new.char[50](u8"/��� 3")
    end

    local wrap = function(stri)
        local t, f = str(stri), {}
        if #t < 101 then return t end
        imgui.StrCopy(sov, string.wrap(t, 100))
        return f
    end
    
    imgui.SetCursorPos{40, 15}
    imgui.PushFont(font[12])
    local p = imgui.GetCursorPos()
    if imgui.InputTextMultiline('##mesteditor', sov, sizeof(sov), {350, 200}) then wrap(sov) end

    imgui.SetCursorPos{p.x, p.y + 201}
    imgui.PushItemWidth(240)
    imgui.InputText("##dffdfdf", ads, sizeof(ads))
    imgui.PopItemWidth()

    imgui.SameLine()
    if imgui.Button("Go", {100, 15}) then
        lua_thread.create(function()
            for line in str(sov):gmatch('[^\n]+') do
                if not line:isEmpty() then
                    local g = str(ads):gsub("%s+", " ")
                    final = g..string.capitalize(line)
                    sampSendChat(u8:decode(final))
                    print(final)
                    wait(1500)
                end
            end
        end)
    end
    imgui.PopFont()
    local g = str(ads):gsub("%s+", " ")
    imgui.SetCursorPosX(p.x)
    imgui.Text(final or (g..u8" ��� ������ ������������� ��������� � ���"))

end


return {'������� ', 'CIRCLE_INFO',  true, "������ ��� �����", gui}
