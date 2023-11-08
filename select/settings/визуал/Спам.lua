
local imgui = require('mimgui')

local ffi = require('ffi')
local new, str, sizeof = imgui.new, ffi.string, ffi.sizeof
local extra = require('sfa.imgui.extra')
local gui = function ()
    imgui.PushItemWidth(300)

    for k, v in ipairs(cfg["����"]["������"]) do
        local char = new.char[200](u8(v.text))

        
        local c = extra.U32ToImVec4(bit.rshift(v.color, 8))


        local col = imgui.GetStyle().Colors[imgui.Col.FrameBg]


        imgui.PushStyleColor(imgui.Col.Button, col)
        if imgui.Button("X", {18, 18}) then table.remove(cfg["����"]["������"], k) cfg() end
        imgui.PopStyleColor()


        imgui.SameLine()


        imgui.PushStyleColor(imgui.Col.Text, c)

        local p = imgui.GetCursorPos()
        if imgui.InputText("##words"..k, char, sizeof(char)) then
            v.text = u8:decode(str(char))
        end
        extra.Separator()


        imgui.PopStyleColor()

        
    end	
    imgui.PopItemWidth()


    if imgui.Button("add") then
        table.insert(cfg["����"]["������"], lastservermsg)
        cfg()
    end


end

return {"����", "������� ��� ������ ������� � ���� ��� �� ���������, � ��������� � �������� ������ �� ���� �� ����� ������������", func = gui}